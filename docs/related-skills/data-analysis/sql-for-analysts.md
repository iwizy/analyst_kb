# [SQL](../../glossary.md#abbr-084) для аналитиков

SQL для аналитика это основной язык проверки гипотез, верификации требований и построения метрик.

## Уровни сложности

### Базовый уровень

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`;
- `GROUP BY`, `HAVING`;
- `INNER/LEFT JOIN`.

### Средний уровень

- CTE и подзапросы;
- оконные функции (`ROW_NUMBER`, `LAG`, `SUM OVER`);
- сегментация и когорты.

### Продвинутый уровень

- оптимизация запросов через `EXPLAIN`;
- контроль качества данных SQL-проверками;
- подготовка воспроизводимых аналитических наборов.

## Практические задачи аналитика

| [Задача](../../glossary.md#term-028) | SQL-паттерн |
| --- | --- |
| [Агрегация](../../glossary.md#term-002) по периодам | `date_trunc` + `group by` |
| Сегментация клиентов | `case when` + группировка |
| Когортный анализ | первая активность + период сдвига |
| Поиск аномалий | оконные функции + сравнение с baseline |

## Пример 1: сегментация клиентов по выручке

```sql
select
  customer_id,
  sum(amount) as revenue,
  case
    when sum(amount) >= 100000 then 'vip'
    when sum(amount) >= 20000 then 'mid'
    else 'base'
  end as segment
from orders
where order_date >= date_trunc('year', current_date)
group by customer_id;
```

## Пример 2: когорты по месяцу первой покупки

```sql
with first_order as (
  select customer_id, min(date_trunc('month', order_date)) as cohort_month
  from orders
  group by customer_id
), activity as (
  select
    o.customer_id,
    date_trunc('month', o.order_date) as activity_month,
    f.cohort_month
  from orders o
  join first_order f on f.customer_id = o.customer_id
)
select
  cohort_month,
  activity_month,
  count(distinct customer_id) as active_users
from activity
group by cohort_month, activity_month
order by cohort_month, activity_month;
```

## Пример 3: скользящая средняя для операционной метрики

```sql
with daily as (
  select
    date(created_at) as dt,
    count(*) as tickets
  from support_tickets
  where created_at >= current_date - interval '30 day'
  group by date(created_at)
)
select
  dt,
  tickets,
  avg(tickets) over (
    order by dt
    rows between 6 preceding and current row
  ) as ma7
from daily
order by dt;
```

## Инструменты

- Metabase: быстрые [SQL](../../glossary.md#abbr-084)-вопросы и дашборды.
- Apache Superset: гибкая [BI](../../glossary.md#abbr-008)-визуализация и SQL Lab.
- DataGrip/DBeaver: удобная работа с запросами и схемой.

## Типовые ошибки

- выборка без ограничений по времени;
- смешение UTC и локального времени;
- `LEFT JOIN`, который фактически превращается в `INNER` из-за фильтра;
- отсутствие валидации дубликатов и `NULL`.

## Кросс-ссылки

- [SQL в разделе БД](../../database/sql/index.md)
- [BI и визуализация](bi-and-visualization.md)
- [Статистика и A/B-тесты](statistics-and-ab-tests.md)## Источники

- PostgreSQL documentation: <https://www.postgresql.org/docs/>
- Mode SQL tutorial: <https://mode.com/sql-tutorial/>
- SQL for Data Analysis (O'Reilly).
