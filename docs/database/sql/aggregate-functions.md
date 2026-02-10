# Агрегатные функции

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Агрегаты превращают события и транзакции в бизнес-метрики.

## Уровни сложности

### Базовый

```sql
SELECT COUNT(*) AS orders_cnt,
       SUM(total_amount) AS revenue,
       AVG(total_amount) AS avg_check
FROM orders
WHERE created_at >= current_date;
```

### Средний

```sql
SELECT date(created_at) AS day,
       status,
       COUNT(*) AS cnt,
       SUM(total_amount) AS amount
FROM orders
WHERE created_at >= current_date - interval '30 days'
GROUP BY day, status
ORDER BY day, status;
```

### Продвинутый

- `FILTER` для условных агрегатов;
- материализованные представления для тяжелых отчетов;
- контроль точности (`numeric` vs floating types).

```sql
SELECT
  COUNT(*) FILTER (WHERE status = 'PAID') AS paid_cnt,
  COUNT(*) FILTER (WHERE status = 'CANCELED') AS canceled_cnt
FROM orders;
```

## Типовые ошибки

- смешение разных уровней гранулярности;
- агрегация без временного фильтра на больших таблицах;
- неверная интерпретация NULL.

## Практические рекомендации

1. Всегда фиксируйте grain метрики (день/клиент/заказ).
2. Добавляйте контрольные сверки на малых выборках.
3. Используйте pre-aggregation для регулярных BI-отчетов.

## Упражнения

1. Рассчитайте конверсию `created -> paid` по дням.
2. Найдите топ-5 категорий по выручке за квартал.
3. Сравните `CASE` и `FILTER` в одном отчете.
## Стандарты и источники

- PostgreSQL aggregate functions: <https://www.postgresql.org/docs/current/functions-aggregate.html>
- ISO/IEC 9075 SQL: <https://www.iso.org/standard/76583.html>
