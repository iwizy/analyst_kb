# Селекты

`SELECT` это базовый инструмент извлечения данных в SQL. Качество `SELECT`-запросов напрямую влияет на производительность, корректность аналитики и стабильность API.

## Базовый шаблон

```sql
SELECT <columns>
FROM <table_or_cte>
[JOIN ...]
[WHERE ...]
[GROUP BY ...]
[HAVING ...]
[ORDER BY ...]
[LIMIT ... OFFSET ...];
```

## Практические паттерны

### 1. Проекция только нужных колонок

```sql
SELECT order_id, customer_id, amount
FROM orders
WHERE created_at >= now() - interval '30 days';
```

Почему: меньше данных читается и передается.

### 2. Фильтрация в `WHERE`

```sql
SELECT customer_id, amount
FROM orders
WHERE status = 'paid'
  AND amount > 1000;
```

### 3. Сортировка и ограничение

```sql
SELECT order_id, created_at, amount
FROM orders
ORDER BY created_at DESC
LIMIT 100;
```

### 4. Соединения таблиц

```sql
SELECT o.order_id, c.full_name, o.amount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status = 'paid';
```

### 5. Пагинация

```sql
SELECT order_id, created_at
FROM orders
ORDER BY created_at DESC
LIMIT 50 OFFSET 100;
```

Для больших таблиц лучше keyset pagination:

```sql
SELECT order_id, created_at
FROM orders
WHERE (created_at, order_id) < ('2026-02-09 12:00:00+00', 120003)
ORDER BY created_at DESC, order_id DESC
LIMIT 50;
```

## Типичные ошибки

- `SELECT *` в продовых запросах;
- отсутствие `ORDER BY` при `LIMIT`;
- неявные cartesian join;
- фильтрация по неиндексированным полям на больших таблицах.

## Практические рекомендации

- писать `SELECT` от реального use-case, а не "на всякий случай";
- проверять план выполнения через `EXPLAIN`;
- для горячих запросов держать контракт колонок стабильным;
- измерять p95/p99 запросов, а не только среднее время.

## Смежные материалы

- [Индексы](indexes.md)
- [Группировка и сортировка](grouping-sorting.md)
- [Вложенные запросы](subqueries.md)
