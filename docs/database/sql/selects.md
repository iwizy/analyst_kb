# Селекты

`SELECT` — базовая операция анализа данных и проверки бизнес-гипотез.

## Уровни сложности

### Базовый

```sql
SELECT order_id, customer_id, total_amount
FROM orders
WHERE status = 'PAID';
```

Правила:

- избегать `SELECT *` в production;
- выбирать только нужные поля;
- ограничивать выдачу (`LIMIT`) в интерактивных сценариях.

### Средний

```sql
SELECT o.order_id, c.email, o.total_amount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.created_at >= now() - interval '30 days'
  AND o.status IN ('PAID', 'SHIPPED')
ORDER BY o.created_at DESC
LIMIT 100;
```

### Продвинутый

Оптимизация IO:

- фильтровать до join (pushdown);
- не использовать функции над индексируемыми полями;
- применять keyset pagination на больших наборах.

Плохой паттерн:

```sql
WHERE date(created_at) = current_date
```

Лучше:

```sql
WHERE created_at >= current_date
  AND created_at < current_date + interval '1 day'
```

## Типовые ошибки

- cartesian join;
- offset pagination на больших таблицах;
- фильтры по неиндексируемым выражениям.

## Практические рекомендации

1. Проверяйте `EXPLAIN ANALYZE` для ключевых select-запросов.
2. Используйте read replica для тяжелых read-only сценариев.
3. Фиксируйте SQL-контракты для критичных API/отчетов.

## Упражнения

1. Напишите запрос последних 50 заказов клиента.
2. Перепишите запрос с `date(column)` в индекс-дружелюбный.
3. Реализуйте keyset pagination по `created_at, order_id`.

## Контрольные вопросы

1. Какие поля запроса должны быть покрыты индексом?
2. Где в плане наибольший cost и почему?
3. Нужна ли для этого запроса read replica?

## Чек-лист самопроверки

- возвращаются только нужные колонки;
- условия фильтрации и сортировки индекс-дружелюбны;
- добавлены ограничения объема выдачи;
- план выполнения проверен на реальном объеме.

## Стандарты и источники

- PostgreSQL SELECT: <https://www.postgresql.org/docs/current/sql-select.html>
- MySQL SELECT: <https://dev.mysql.com/doc/refman/en/select.html>
