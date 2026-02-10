# Инструменты работы с БД

Раздел описывает инструменты аналитика и DBA для проектирования схем, миграций, диагностики запросов и эксплуатации SQL/NoSQL платформ.

## Уровни сложности

### Базовый уровень

- подключаться к БД безопасно;
- выполнять и проверять SQL-запросы;
- читать планы выполнения и базовые метрики.

### Средний уровень

- управлять миграциями схем;
- диагностировать производительность;
- работать с NoSQL/NewSQL инструментами.

### Продвинутый уровень

- интегрировать database workflow в CI/CD;
- контролировать schema drift и rollback;
- выстраивать мониторинг и DR-процедуры.

## Категории инструментов

| Категория | Инструменты | Назначение |
| --- | --- | --- |
| SQL IDE/clients | DataGrip, DBeaver, pgAdmin, SSMS | запросы, диагностика, администрирование |
| NoSQL clients | Mongo Compass, Studio 3T, Robo 3T, Cassandra Query Tool | анализ коллекций/документов/таблиц |
| NewSQL clients | CockroachDB SQL client, Yugabyte/YSQL tooling | distributed SQL диагностика |
| Schema modeling | dbdiagram.io, SQLDBM | документирование и проектирование схем |
| Migrations | Flyway, Liquibase | контролируемые schema changes |
| Monitoring | pgBadger, pganalyze, Grafana dashboards | производительность и эксплуатация |

## Сравнение DataGrip vs DBeaver

| Критерий | DataGrip | DBeaver |
| --- | --- | --- |
| Поддержка СУБД | широкая | очень широкая |
| SQL-ассистент | сильный | хороший |
| Стоимость | commercial | есть community + paid |
| Подходит для | интенсивная SQL-разработка | универсальный многоплатформенный клиент |

## Практические сценарии

### Создание и проверка схемы

1. Спроектировать структуру в dbdiagram.io/SQLDBM.
2. Сгенерировать DDL.
3. Прогнать DDL на dev-среде.
4. Проверить индексы и ограничения.

### Оптимизация запроса

1. Выполнить `EXPLAIN (ANALYZE, BUFFERS)`.
2. Найти full scan и дорогие join.
3. Добавить/скорректировать индекс.
4. Сравнить план до/после.

### Миграции с Liquibase

1. Создать changeset.
2. Прогнать в dev/test.
3. Проверить rollback script.
4. Включить в CI/CD pipeline.

```xml
<changeSet id="2026-02-10-add-order-index" author="analyst">
  <createIndex tableName="orders" indexName="idx_orders_created_at">
    <column name="created_at"/>
  </createIndex>
</changeSet>
```

## DBA-практики и контроль доступа

- раздельные роли доступа (read-only/read-write/admin);
- secrets management вместо hardcoded credentials;
- регулярный backup/restore drill;
- review DDL изменений перед production.

## Docker для локальных БД

- поднимать изолированные dev-инстансы для тестов;
- воспроизводить окружение через versioned `docker compose`;
- использовать seed scripts и миграции при старте.

## Интеграция с CI/CD

- шаг миграций до application deploy;
- проверки schema drift;
- rollback strategy и verification tests;
- публикация migration report.

## Зависимость от архитектурного стиля

- Монолит: акцент на quality SQL, миграционный контур и query tuning.
- Микросервисы: акцент на schema ownership по сервисам и backward-compatible migrations.
- Event-driven: акцент на CDC, schema evolution и согласованность read models.

## Связь с требованиями и SDLC

- анализ: верификация логической модели и нормализации;
- проектирование: фиксация ограничений и связей;
- разработка: миграции и SQL review;
- тестирование: data integrity/performance checks;
- эксплуатация: мониторинг, бэкапы, capacity planning.

## Кросс-ссылки

- [Базы данных](../database/index.md)
- [Нормализация и денормализация](../database/normalization/index.md)
- [Процесс разработки: DevOps](../development-process/product-lifecycle/devops-basics.md)
- [Интеграции: Общая БД](../integrations/integration-methods/shared-database.md)

## Типичные ошибки

- изменения схемы в production без миграционного контура;
- отсутствие rollback и теста восстановления;
- запросы без анализа execution plan;
- смешение учеток и прав доступа.

## Чек-лист самопроверки

- выбран подходящий SQL/NoSQL инструмент под задачу;
- миграции версионируются и проходят CI;
- query performance контролируется по метрикам;
- backup/restore процесс проверяется регулярно.

## Источники

- DataGrip: <https://www.jetbrains.com/datagrip/>
- DBeaver: <https://dbeaver.io/>
- pgAdmin: <https://www.pgadmin.org/>
- Liquibase: <https://www.liquibase.org/>
- Flyway: <https://flywaydb.org/>
- Mongo Compass: <https://www.mongodb.com/products/compass>
- dbdiagram: <https://dbdiagram.io/home>
- pganalyze: <https://pganalyze.com/>

## Актуализация

- проверяйте совместимость клиентов после обновления СУБД;
- обновляйте migration/gateway политики при изменении CI/CD и security-контуров.
