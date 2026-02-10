# Оконные функции

Оконные функции позволяют делать аналитические вычисления по строкам без потери детализации.

## Уровни сложности

### Базовый

```sql
SELECT order_id,
       customer_id,
       total_amount,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_at DESC) AS rn
FROM orders;
```

### Средний

```sql
SELECT date(created_at) AS day,
       SUM(total_amount) AS day_revenue,
       SUM(SUM(total_amount)) OVER (ORDER BY date(created_at)) AS cumulative_revenue
FROM orders
GROUP BY day
ORDER BY day;
```

### Продвинутый

- `LAG/LEAD` для анализа изменений;
- rolling windows для трендов;
- контроль памяти и сортировок в больших partition.

```sql
SELECT customer_id,
       created_at,
       total_amount,
       LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY created_at) AS prev_amount
FROM orders;
```

## Типовые ошибки

- неверный `PARTITION BY`;
- недетерминированный `ORDER BY`;
- тяжелые окна без pre-aggregation.

## Практические рекомендации

1. Явно фиксируйте бизнес-смысл окна.
2. Ограничивайте размер partition где возможно.
3. Для тяжелых отчетов используйте промежуточные витрины.

## Упражнения

1. Рассчитайте rolling 7-day revenue.
2. Найдите клиентов с ростом чека неделя к неделе.
3. Добавьте percentile по времени обработки заявки.

## Контрольные вопросы

1. Какое окно соответствует требуемой метрике?
2. Как влияет размер partition на latency?
3. Нужна ли materialized view перед окном?

## Чек-лист самопроверки

- partition/order ключи выбраны корректно;
- результаты проверены на контрольной выборке;
- производительность подтверждена на целевом объеме;
- логика окна документирована.

## Стандарты и источники

- PostgreSQL window functions: <https://www.postgresql.org/docs/current/functions-window.html>
- Oracle analytic functions: <https://docs.oracle.com/en/database/oracle/oracle-database/>
