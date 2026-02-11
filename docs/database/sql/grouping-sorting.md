# Группировка и сортировка

`GROUP BY` и `ORDER BY` определяют форму аналитического результата и часто создают основную вычислительную нагрузку.

## Уровни сложности

### Базовый уровень

```sql
SELECT status, COUNT(*)
FROM orders
GROUP BY status
ORDER BY status;
```

### Средний уровень

```sql
SELECT customer_id,
       SUM(total_amount) AS revenue
FROM orders
WHERE created_at >= date_trunc('month', now())
GROUP BY customer_id
HAVING SUM(total_amount) > 100000
ORDER BY revenue DESC
LIMIT 20;
```

### Продвинутый уровень

- индексная поддержка `ORDER BY + LIMIT`;
- контроль memory spill при сортировке;
- pre-aggregation для тяжелых отчетов.

## Типовые ошибки

- сортировка больших наборов без ограничения;
- группировка по полям без бизнес-смысла;
- фильтрация после группировки там, где можно до.

## Практические рекомендации

1. Сокращайте входной набор до `GROUP BY`.
2. Для top-N используйте комбинацию индекс + `LIMIT`.
3. Проверяйте sort/aggregate шаги в плане.

## Упражнения

1. Постройте рейтинг клиентов по обороту с порогом через `HAVING`.
2. Сравните план до и после добавления индекса под сортировку.
3. Найдите случай ненужной сортировки и исправьте запрос.
## Стандарты и источники

- PostgreSQL ORDER BY: <https://www.postgresql.org/docs/current/queries-order.html>
- MySQL ORDER BY optimization: <https://dev.mysql.com/doc/refman/en/order-by-optimization.html>
