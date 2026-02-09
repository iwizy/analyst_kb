# Агрегатные функции

Агрегатные функции вычисляют сводные значения по набору строк.

## Базовые функции

- `COUNT` — количество строк/значений;
- `SUM` — сумма;
- `AVG` — среднее;
- `MIN` / `MAX` — минимум/максимум.

## Примеры

### COUNT

```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

```sql
SELECT COUNT(amount) AS amount_non_null
FROM orders;
```

### SUM/AVG

```sql
SELECT SUM(amount) AS total_revenue,
       AVG(amount) AS avg_order
FROM orders
WHERE status = 'paid';
```

### MIN/MAX

```sql
SELECT MIN(amount) AS min_order,
       MAX(amount) AS max_order
FROM orders;
```

## Агрегация с группировкой

```sql
SELECT customer_id,
       COUNT(*) AS orders_cnt,
       SUM(amount) AS revenue
FROM orders
WHERE status = 'paid'
GROUP BY customer_id;
```

## FILTER (PostgreSQL)

```sql
SELECT
  COUNT(*) FILTER (WHERE status = 'paid')   AS paid_cnt,
  COUNT(*) FILTER (WHERE status = 'refund') AS refund_cnt
FROM orders;
```

## DISTINCT внутри агрегатов

```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;
```

## NULL и агрегаты

- `COUNT(*)` считает все строки;
- `COUNT(column)` игнорирует `NULL`;
- `SUM/AVG/MIN/MAX` игнорируют `NULL`.

## Типичные ошибки

- смешивать агрегаты и неагрегированные поля без `GROUP BY`;
- использовать `COUNT(*)` вместо `COUNT(DISTINCT ...)` в задачах уникальности;
- не учитывать влияние `NULL` на результат.

## Практические рекомендации

- явно задавать бизнес-правила фильтрации (`status`, даты, отмены);
- для больших отчетов использовать партиционирование/витрины;
- сравнивать агрегаты с контрольными метриками (data quality).

## Смежные материалы

- [Группировка и сортировка](grouping-sorting.md)
- [Оконные функции](window-functions.md)
