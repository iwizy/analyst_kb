# SQL

SQL это язык работы с реляционными данными: выборка, изменение, агрегирование и управление схемой.

## Зачем аналитикам SQL

- формулировать требования к данным и отчетности;
- проверять корректность реализации бизнес-правил;
- анализировать инциденты и аномалии в данных;
- готовить витрины и контрольные выборки.

## Базовые классы команд

- DDL: `CREATE`, `ALTER`, `DROP`;
- DML: `SELECT`, `INSERT`, `UPDATE`, `DELETE`;
- DCL: `GRANT`, `REVOKE`;
- TCL: `BEGIN`, `COMMIT`, `ROLLBACK`.

## Практические примеры

```sql
SELECT customer_id, SUM(amount) AS total
FROM orders
WHERE created_at >= date_trunc('month', now())
GROUP BY customer_id
ORDER BY total DESC
LIMIT 10;
```

```sql
BEGIN;
UPDATE account SET balance = balance - 500 WHERE account_id = 101;
UPDATE account SET balance = balance + 500 WHERE account_id = 202;
COMMIT;
```

## Частые ошибки

- `SELECT *` в критичных запросах;
- отсутствие индексов для join/filter полей;
- неконтролируемые подзапросы и cartesian joins;
- игнорирование транзакционных границ.

## Практические рекомендации

- проверять планы запроса через `EXPLAIN`;
- разделять OLTP-запросы и аналитические batch-запросы;
- фиксировать SQL-контракты для критичных отчетов;
- использовать CTE и window functions для читаемости и повторяемости.

## Переход к подразделам

- [Селекты](selects.md)
- [Агрегатные функции](aggregate-functions.md)
- [Группировка и сортировка](grouping-sorting.md)
- [Вложенные запросы](subqueries.md)
- [Индексы](indexes.md)
- [Хранимые процедуры и пользовательские функции](stored-procedures-and-udf.md)
- [Оконные функции](window-functions.md)
