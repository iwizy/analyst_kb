# Оконные функции

Оконные функции выполняют вычисления по набору строк без схлопывания результата, в отличие от `GROUP BY`. Это ключевой инструмент аналитических SQL-запросов.

## Базовый синтаксис

```sql
<window_function>() OVER (
  [PARTITION BY ...]
  [ORDER BY ...]
  [ROWS/RANGE frame]
)
```

## Популярные функции

- `ROW_NUMBER` — уникальная нумерация строк;
- `RANK`, `DENSE_RANK` — ранжирование;
- `LAG`, `LEAD` — доступ к соседним строкам;
- `SUM/AVG/... OVER` — накопительные и скользящие агрегаты.

## Примеры

### Ранжирование по сумме заказов

```sql
SELECT customer_id,
       SUM(amount) AS revenue,
       DENSE_RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM orders
WHERE status = 'paid'
GROUP BY customer_id;
```

### Соседние значения (LAG)

```sql
SELECT created_at::date AS day,
       SUM(amount) AS revenue,
       LAG(SUM(amount)) OVER (ORDER BY created_at::date) AS prev_revenue
FROM orders
WHERE status = 'paid'
GROUP BY day
ORDER BY day;
```

### Накопительный итог

```sql
SELECT created_at::date AS day,
       SUM(amount) AS day_revenue,
       SUM(SUM(amount)) OVER (ORDER BY created_at::date) AS running_total
FROM orders
WHERE status = 'paid'
GROUP BY day
ORDER BY day;
```

### Скользящее среднее 7 дней

```sql
SELECT day,
       revenue,
       AVG(revenue) OVER (
         ORDER BY day
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS ma7
FROM daily_revenue;
```

## Где особенно полезны

- дашборды и KPI-аналитика;
- cohort/retention отчеты;
- anomaly detection на временных рядах;
- топы и ранжирование в BI.

## Типичные ошибки

- неверный frame (`ROWS` vs `RANGE`);
- отсутствие `ORDER BY` в оконной функции, где он обязателен по смыслу;
- смешение `GROUP BY` и окон без понимания уровня агрегации.

## Практические рекомендации

- сначала фиксировать grain (уровень строки) результата;
- для читаемости использовать CTE до оконных вычислений;
- проверять, как окно влияет на память/сортировку в плане запроса;
- сложные вычисления материализовать в витрины.

## Смежные материалы

- [Агрегатные функции](aggregate-functions.md)
- [Группировка и сортировка](grouping-sorting.md)
