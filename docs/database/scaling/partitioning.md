# Партиционирование

Партиционирование делит крупную таблицу на управляемые части, чтобы ускорить выборки, упростить архивирование и снизить эксплуатационные риски.

## Уровни сложности

### Базовый уровень

- range/list/hash partition;
- partition pruning.

### Средний уровень

- lifecycle policy: create, detach, archive, drop;
- локальные индексы и статистика по разделам.

### Продвинутый уровень

- online repartitioning и zero-downtime миграции;
- комбинированное партиционирование для multi-tenant.

## Типы партиционирования

| Тип | Когда применять |
| --- | --- |
| Range | данные по времени (orders/events/logs) |
| List | ограниченный набор значений (регион/тенант) |
| Hash | равномерное распределение ключей |

## Пример (range by month)

```sql
CREATE TABLE orders (
  order_id BIGINT,
  created_at DATE,
  total_amount NUMERIC(14,2)
) PARTITION BY RANGE (created_at);
```

## Практика эксплуатации

- создавать разделы заранее (rolling window);
- контролировать размер и skew;
- архивировать старые разделы в cold storage;
- держать runbook на attach/detach.

## Типовые ошибки

- неверный ключ партиции, не соответствующий фильтрам;
- слишком много мелких разделов;
- отсутствие автоматизации жизненного цикла партиций.

## Практические рекомендации

1. Выбирайте ключ партиции по доминирующим фильтрам.
2. Держите target размер раздела, например 5-50 GB для [OLTP](../../glossary.md#abbr-060) событийных таблиц.
3. Проверяйте pruning через `EXPLAIN`.
4. Автоматизируйте housekeeping и архивирование.
## Стандарты и источники

- PostgreSQL partitioning: <https://www.postgresql.org/docs/current/ddl-partitioning.html>
- MySQL partitioning: <https://dev.mysql.com/doc/refman/en/partitioning.html>
