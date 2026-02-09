# Реляционные базы данных

Реляционные БД используют табличную модель, SQL и строгие ограничения целостности. Это базовый выбор для транзакционных систем, где критичны корректность и предсказуемость данных.

## Когда выбирать

- нужна строгая консистентность и транзакции ACID;
- важны сложные запросы, JOIN и агрегаты;
- доменная модель стабильна и хорошо формализуема;
- есть требования к аудиту и нормативному соответствию.

## Примеры систем

- PostgreSQL
- MySQL / MariaDB
- Oracle Database
- Microsoft SQL Server
- IBM Db2

## Пример схемы и запроса

```sql
CREATE TABLE customers (
  customer_id BIGSERIAL PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL
);

CREATE TABLE orders (
  order_id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT NOT NULL REFERENCES customers(customer_id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0)
);

SELECT c.full_name, SUM(o.amount) AS total_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_amount DESC;
```

## Достоинства

- строгая модель данных и целостность через PK/FK/constraints;
- развитый SQL-экосистемный стек;
- зрелые инструменты бэкапа, миграций, мониторинга;
- сильная поддержка транзакций и изоляции.

## Недостатки

- сложнее горизонтально масштабировать write-heavy нагрузки;
- rigid schema при частых изменениях модели;
- дорогостоящие JOIN на очень больших, плохо индексированных таблицах.

## Типовые области применения

- платежные и биллинговые системы;
- учет и ERP;
- CRM и back-office системы;
- core-сервисы с транзакционной целостностью.

## Практические рекомендации

- начинать с нормализованной модели (до 3NF), денормализацию делать осознанно;
- использовать индексы под реальные паттерны запросов;
- избегать "SELECT *" в критичных сервисах;
- регулярно анализировать планы запросов (`EXPLAIN ANALYZE`).

## Смежные материалы

- [Нормализация и денормализация](../normalization/index.md)
- [Проектирование модели данных](../data-modeling.md)
- [Индексы](../sql/indexes.md)
