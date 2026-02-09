# Инструменты работы с БД

## Популярные решения

| Инструмент | Когда использовать | Плюсы | Минусы |
| --- | --- | --- | --- |
| pgAdmin | администрирование PostgreSQL | бесплатный, удобен для DBA/аналитики | фокус в основном на PostgreSQL |
| DataGrip | SQL-разработка в мульти-СУБД среде | мощный редактор и анализ SQL | коммерческая лицензия |
| DBeaver | универсальный SQL-клиент | широкий спектр СУБД, community edition | часть advanced функций в paid-версии |
| SQL Server Management Studio | MS SQL-контур | глубокая интеграция с SQL Server | узкая привязка к экосистеме MS |

## Как начать

1. Настройте безопасные подключения по контурам (dev/test/prod readonly).
1. Используйте шаблоны запросов и форматирование SQL.
1. Для критичных запросов проверяйте планы выполнения.
1. Фиксируйте миграции и изменения схем в version control.

## Официальные ресурсы

- pgAdmin: <https://www.pgadmin.org/>
- DataGrip: <https://www.jetbrains.com/datagrip/>
- DBeaver: <https://dbeaver.io/>
- SSMS: <https://learn.microsoft.com/sql/ssms/>
