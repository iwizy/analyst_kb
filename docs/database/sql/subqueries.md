# Вложенные запросы

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Подзапросы удобны для выражения сложных условий, но требуют контроля плана выполнения.

## Уровни сложности

### Базовый

```sql
SELECT order_id, customer_id
FROM orders
WHERE customer_id IN (
  SELECT customer_id
  FROM vip_customers
);
```

### Средний

```sql
SELECT c.customer_id, c.email
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.customer_id = c.customer_id
    AND o.created_at >= now() - interval '90 days'
);
```

### Продвинутый

- сравнивайте `IN`, `EXISTS`, `JOIN` по плану;
- избегайте коррелированных подзапросов на больших наборах;
- используйте CTE для читаемости и дебага.

## Типовые ошибки

- коррелированный subquery без индекса;
- подзапрос возвращает избыточный объем;
- вложенная логика, которую проще выразить join.

## Практические рекомендации

1. Для semi-join сценариев чаще эффективен `EXISTS`.
2. Проверяйте оптимизацию через EXPLAIN на production-like данных.
3. Для сложных сценариев делите запрос на этапы.

## Упражнения

1. Перепишите `IN` в `EXISTS` и сравните планы.
2. Уберите коррелированный подзапрос через `JOIN`.
3. Разбейте сложный запрос на CTE-шаги.
## Стандарты и источники

- PostgreSQL subqueries: <https://www.postgresql.org/docs/current/functions-subquery.html>
- SQL style guide: <https://www.sqlstyle.guide/>
