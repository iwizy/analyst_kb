# Вложенные запросы

Вложенный запрос (subquery) это запрос внутри другого запроса. Он позволяет вычислять промежуточные результаты и использовать их в фильтрации, проекции и источнике данных.

## Виды подзапросов

- в `WHERE`;
- в `FROM`;
- в `SELECT`;
- коррелированные и некоррелированные;
- `EXISTS` / `IN` / scalar subquery.

## Примеры

### 1. Подзапрос в WHERE

```sql
SELECT full_name
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM orders
  WHERE status = 'paid'
);
```

### 2. EXISTS

```sql
SELECT c.customer_id, c.full_name
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.customer_id = c.customer_id
    AND o.status = 'paid'
);
```

### 3. Подзапрос в FROM

```sql
SELECT t.customer_id, t.revenue
FROM (
  SELECT customer_id, SUM(amount) AS revenue
  FROM orders
  WHERE status = 'paid'
  GROUP BY customer_id
) t
WHERE t.revenue > 10000;
```

### 4. Подзапрос в SELECT

```sql
SELECT c.customer_id,
       c.full_name,
       (
         SELECT COUNT(*)
         FROM orders o
         WHERE o.customer_id = c.customer_id
       ) AS orders_cnt
FROM customers c;
```

## CTE как альтернатива для читаемости

```sql
WITH paid_orders AS (
  SELECT customer_id, SUM(amount) AS revenue
  FROM orders
  WHERE status = 'paid'
  GROUP BY customer_id
)
SELECT *
FROM paid_orders
WHERE revenue > 10000;
```

## Типичные ошибки

- тяжелые коррелированные подзапросы в больших выборках;
- `IN` по большим наборам без нужных индексов;
- вложенность без явной необходимости, ухудшающая читаемость.

## Практические рекомендации

- проверять, можно ли заменить подзапрос на `JOIN`/CTE;
- использовать `EXISTS` для semijoin-сценариев;
- для критичных запросов проверять план выполнения;
- индексировать поля, участвующие в корреляции.

## Смежные материалы

- [Селекты](selects.md)
- [Индексы](indexes.md)
