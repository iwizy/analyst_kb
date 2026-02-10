# Реплицирование данных

Репликация повышает доступность и масштабируемость чтения, но требует контроля lag, failover и консистентности на уровне сценариев.

## Уровни сложности

### Базовый

- primary/replica топология;
- sync vs async replication.

### Средний

- physical vs logical replication;
- read/write splitting и sticky sessions.

### Продвинутый

- failover/switchover automation;
- CDC pipelines (Debezium/Kafka Connect/GoldenGate).

## Механизмы репликации

| Механизм | Описание | Когда применять |
| --- | --- | --- |
| Physical replication | копирование WAL/binlog на уровне страниц/блоков | HA и read replicas |
| Logical replication | репликация таблиц/строк/событий | selective replication, интеграции |
| Statement-based (MySQL) | передача SQL-операций | ограниченно, есть риски недетерминизма |
| Row-based (MySQL) | передача изменений строк | чаще предпочтительно для надежности |
| Streaming replication | непрерывная передача журнала | near-real-time replica |

## Failover и Switchover

| Операция | Смысл |
| --- | --- |
| Failover | аварийное переключение на replica |
| Switchover | плановое переключение ролей |

Практика:

- автоматизация через orchestrator/patroni и health checks;
- обязательные drills и измерение recovery time.

## Read/Write splitting

- write всегда в primary;
- read-heavy запросы — в replicas;
- для read-after-write использовать sticky routing или primary read.

## CDC (Change Data Capture)

Типовой стек:

- Debezium + Kafka Connect + Kafka;
- Oracle GoldenGate;
- native logical decoding.

Применение:

- синхронизация в DWH/search/cache;
- event-driven интеграции;
- аудит и replay.

## Метрики мониторинга

- replication lag;
- replica apply rate;
- failover success rate;
- write availability during failover;
- read-after-write consistency violations.

## Типовые ошибки

- считать реплику заменой backup;
- использовать replica для критичного read-after-write без sticky policy;
- не тестировать failover под нагрузкой;
- игнорировать schema drift в logical replication.

## Практические рекомендации

1. Определите SLA на lag для каждого read-сценария.
2. Разделите HA-репликацию и аналитический CDC контур.
3. Ведите runbook: failover, switchover, rollback.
4. Проводите регулярные game day тесты.

## Контрольные вопросы

1. Какие сценарии чувствительны к replication lag?
2. Какой механизм репликации выбран и почему?
3. Как автоматически выполняется failover?
4. Как контролируется качество CDC потока?

## Чек-лист самопроверки

- выбран и обоснован тип репликации;
- настроены lag/health метрики и алерты;
- failover/switchover автоматизированы и протестированы;
- CDC pipeline имеет контроль целостности;
- read/write splitting учитывает consistency требования.

## Стандарты и источники

- PostgreSQL replication: <https://www.postgresql.org/docs/current/runtime-config-replication.html>
- MySQL replication: <https://dev.mysql.com/doc/refman/en/replication.html>
- Debezium docs: <https://debezium.io/documentation/>
- Kafka Connect docs: <https://kafka.apache.org/documentation/#connect>
