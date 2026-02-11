# Планы выполнения и оптимизация SQL

Оптимизация SQL начинается не с переписывания запроса, а с чтения фактического плана выполнения. Главная цель: уменьшить объем ненужного чтения и стабилизировать p95/p99 latency.

## Уровни сложности

### Базовый уровень

- читать `EXPLAIN`;
- находить full scan и тяжелые сортировки.

### Средний уровень

- использовать `EXPLAIN ANALYZE` и метрики `rows`, `loops`, `buffers`;
- сопоставлять план с индексами и статистикой.

### Продвинутый уровень

- оптимизировать join order и memory settings;
- проектировать materialized views и read-модели под [OLAP](../../glossary.md#abbr-059).

## Что смотреть в плане выполнения

| Поле | Что означает | На что обращать внимание |
| --- | --- | --- |
| Node type | тип операции (Seq Scan, Index Scan, Hash Join) | соответствует ли профилю запроса |
| Rows (estimated/actual) | оценка и факт количества строк | сильное расхождение = проблема статистики |
| Loops | число повторов узла | high loops на дорогом узле = риск |
| Buffers / IO | чтение страниц из памяти/диска | высокий disk read = кандидат на оптимизацию |
| Sort/Hash memory | память на сортировки и hash | spill на диск ухудшает latency |

## Базовый workflow оптимизации

1. Зафиксировать проблемный запрос и его SLA.
1. Снять `EXPLAIN (ANALYZE, BUFFERS)`.
1. Найти самый дорогой узел по времени и IO.
1. Проверить индексы и предикаты (`WHERE`, `JOIN`, `ORDER BY`).
1. Повторно снять план и сравнить результаты.

## Пример чтения плана

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.order_id, o.created_at
FROM orders o
WHERE o.customer_id = 10042
ORDER BY o.created_at DESC
LIMIT 20;
```

Типовой вывод:

- `Seq Scan on orders` при большом объеме таблицы;
- `Sort` с чтением множества страниц;
- фактическое время значительно выше SLA.

После индекса:

```sql
CREATE INDEX idx_orders_customer_created_desc
  ON orders (customer_id, created_at DESC);
```

Ожидаемый эффект:

- переход на `Index Scan`;
- меньше сортировки и дискового IO;
- стабильный latency на keyset-запросе.

## Join order и селективность

Практика:

- сначала фильтровать наиболее селективные наборы;
- избегать функций над индексными колонками;
- разбивать сложные отчеты на staging CTE/materialized layers.

Пример неудачного фильтра:

```sql
WHERE date(created_at) = current_date
```

Лучше:

```sql
WHERE created_at >= current_date
  AND created_at < current_date + interval '1 day'
```

## Уменьшение IO

- выбирать только нужные колонки;
- использовать covering/compound indexes под частые запросы;
- ограничивать `OFFSET` на больших наборах, применять keyset pagination;
- выносить тяжелую аналитику в read replica или [DWH](../../glossary.md#abbr-029).

## Materialized view для тяжелых отчетов

```sql
CREATE MATERIALIZED VIEW mv_revenue_daily AS
SELECT date(created_at) AS day,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY day;
```

Использовать, когда приемлема ограниченная задержка обновления и нужно снизить нагрузку на OLTP.

## Типовые ошибки

- оптимизация без baseline-метрик;
- добавление индексов без проверки влияния на write path;
- тюнинг только одного запроса при системной проблеме модели данных;
- игнорирование устаревшей статистики planner.

## Практические рекомендации

1. Храните "до/после" планы для всех критичных запросов.
2. Оптимизируйте по профилю нагрузки, а не по среднему времени.
3. Регулярно обновляйте статистику и проверяйте bloat.
4. Для top-N дорогих запросов ведите owner и SLA.

## Стандарты и источники

- PostgreSQL EXPLAIN: <https://www.postgresql.org/docs/current/using-explain.html>
- PostgreSQL planner stats: <https://www.postgresql.org/docs/current/planner-stats.html>
- MySQL EXPLAIN: <https://dev.mysql.com/doc/refman/en/explain.html>
- Use The Index, Luke: <https://use-the-index-luke.com/>
