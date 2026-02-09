# SQL для аналитиков

SQL - базовый инструмент для извлечения и проверки данных.

## Что должен уметь аналитик

- `SELECT`, `JOIN`, `GROUP BY`, `HAVING`;
- оконные функции (`ROW_NUMBER`, `SUM OVER`, `LAG/LEAD`);
- CTE и подзапросы;
- базовая оптимизация запросов по плану выполнения.

## Пример

```sql
with daily as (
  select
    date(created_at) as dt,
    count(*) as orders_cnt,
    sum(amount) as revenue
  from orders
  where created_at >= current_date - interval '30 day'
  group by date(created_at)
)
select
  dt,
  orders_cnt,
  revenue,
  avg(revenue) over (order by dt rows between 6 preceding and current row) as revenue_ma7
from daily
order by dt;
```

## Практические советы

- всегда ограничивайте выборку по времени;
- проверяйте дубликаты и `null`;
- фиксируйте версии запросов для отчетов.

## Для дальнейшего изучения

- PostgreSQL docs: <https://www.postgresql.org/docs/>
- SQL tutorial (Mode): <https://mode.com/sql-tutorial/>
