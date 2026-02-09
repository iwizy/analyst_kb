# Селекты

Селекты (SELECT) — это одна из основных команд SQL, которая используется для извлечения данных из базы данных. Она позволяет выбирать нужные столбцы и строки из таблицы, применять фильтрацию, сортировку, группировку и объединение данных. Рассмотрим основные аспекты использования SELECT с примерами.

## Основной синтаксис SELECT

```
SELECT [столбцы] FROM [таблица] [WHERE условия] [GROUP BY группировка] [HAVING условия для группировки] [ORDER BY сортировка] [LIMIT ограничение];
```

## Примеры использования

### Выбор всех данных из таблицы

```
SELECT * FROM employees;
```

Здесь * означает, что будут выбраны все столбцы таблицы employees.

### Выбор определённых столбцов

```
SELECT first_name, last_name, salary FROM employees;
```

Этот запрос выберет только столбцы first_name, last_name и salary.

### Фильтрация данных с помощью WHERE

```
SELECT first_name, salary FROM employees WHERE salary > 50000;
```

Запрос возвращает сотрудников, у которых зарплата больше 50,000.

Можно комбинировать условия с помощью операторов:

- AND (И)
- OR (ИЛИ)
- NOT (НЕ)
Пример с несколькими условиями:

```
SELECT first_name, salary FROM employees WHERE salary > 50000 AND department_id = 10;
```

### Сортировка данных с помощью ORDER BY

```
SELECT first_name, salary FROM employees ORDER BY salary DESC;
```

Запрос отсортирует сотрудников по убыванию зарплаты (DESC — по убыванию, ASC — по возрастанию).

### Ограничение количества строк с LIMIT

```
SELECT first_name, salary FROM employees ORDER BY salary DESC LIMIT 5;
```

Этот запрос вернёт 5 сотрудников с самой высокой зарплатой.

### Группировка данных с GROUP BY

```
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id;
```

Запрос возвращает среднюю зарплату (AVG(salary)) для каждого отдела (department_id).

### Условия для группировки с HAVING

```
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) > 60000;
```

HAVING применяется для фильтрации уже агрегированных данных. В данном случае запрос возвращает только те отделы, где средняя зарплата больше 60,000.

### Объединение таблиц с JOIN

```
SELECT e.first_name, e.last_name, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id;
```

Этот запрос объединяет таблицы employees и departments по столбцу department_id, выводя имена сотрудников и их отделы.

### Использование подзапросов

Подзапросы (subqueries) позволяют использовать результат одного запроса в другом:

```
SELECT first_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
```

Запрос возвращает сотрудников, чья зарплата выше средней.

### Работа с агрегатными функциями

- COUNT() — подсчёт строк.
- SUM() — сумма.
- AVG() — среднее значение.
- MIN() / MAX() — минимальное и максимальное значения.
Пример:

```
SELECT COUNT(*) AS total_employees, MAX(salary) AS highest_salary FROM employees;
```

Этот запрос подсчитает количество сотрудников и найдет максимальную зарплату.

### Преобразование данных с помощью функций

SQL поддерживает встроенные функции для работы с текстом, числами и датами.

Пример работы с текстом:

```
SELECT UPPER(first_name) AS uppercase_name FROM employees;
```

### Объединение результатов с UNION

```
SELECT first_name FROM employees WHERE department_id = 10 UNION SELECT first_name FROM employees WHERE department_id = 20;
```

Запрос объединяет имена сотрудников из отделов 10 и 20 (без дублирования строк).

## Заключение

Команда SELECT чрезвычайно мощная и гибкая. Она позволяет выполнять простые выборки, сложные фильтрации, группировки, объединения данных и многое другое. Для повышения эффективности работы важно понимать её возможности и уметь комбинировать различные операторы.

> Материал адаптирован по статье `https://iwizy.github.io/database/sql/select`.

