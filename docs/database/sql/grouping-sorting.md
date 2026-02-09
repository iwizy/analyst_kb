# Группировка и сортировка

`GROUP BY` и `ORDER BY` используются в аналитических и отчетных запросах для сводной статистики и ранжирования результатов.

## GROUP BY

`GROUP BY` объединяет строки в группы и позволяет применять агрегатные функции.

```sql
SELECT customer_id, SUM(amount) AS total_amount
FROM orders
WHERE status = 'paid'
GROUP BY customer_id;
```

## HAVING

`HAVING` фильтрует уже агрегированные группы.

```sql
SELECT customer_id, SUM(amount) AS total_amount
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 10000;
```

## ORDER BY

`ORDER BY` задает порядок строк.

```sql
SELECT order_id, amount
FROM orders
ORDER BY amount DESC, order_id ASC;
```

## Комбинация GROUP BY + ORDER BY

```sql
SELECT date_trunc('day', created_at) AS day,
       COUNT(*) AS orders_cnt,
       SUM(amount) AS revenue
FROM orders
WHERE status = 'paid'
GROUP BY day
ORDER BY day;
```

## Частые сценарии

### Топ клиентов

```sql
SELECT customer_id, SUM(amount) AS total_amount
FROM orders
WHERE status = 'paid'
GROUP BY customer_id
ORDER BY total_amount DESC
LIMIT 10;
```

### Отчет по категориям

```sql
SELECT category, COUNT(*) AS products_cnt
FROM products
GROUP BY category
ORDER BY products_cnt DESC;
```

## Типичные ошибки

- использовать `HAVING` вместо `WHERE` без необходимости;
- включать в `SELECT` поля, которых нет в `GROUP BY` и агрегатах;
- сортировать большие выборки без нужных индексов;
- ожидать deterministic-порядок без `ORDER BY`.

## Практические рекомендации

- фильтровать как можно раньше (`WHERE` до `GROUP BY`);
- проверять cardinality групп для оценки памяти/времени;
- использовать материализованные витрины для тяжелых отчетов;
- для часто используемых сводок готовить pre-aggregation.

## Смежные материалы

- [Агрегатные функции](aggregate-functions.md)
- [Оконные функции](window-functions.md)
- [Индексы](indexes.md)
