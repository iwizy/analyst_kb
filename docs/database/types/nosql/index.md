# NoSQL базы данных

NoSQL применяется, когда профиль данных и нагрузки плохо укладывается в классическую реляционную модель или требует специализированной оптимизации.

## Уровни сложности

### Базовый

- понимать 6 основных подтипов: document, key-value, wide-column, time-series, graph, search;
- различать ACID и BASE ожидания в каждом подтипе.

### Средний

- проектировать индексы и модель данных под конкретный access pattern;
- управлять eventual consistency и целостностью на уровне приложения.

### Продвинутый

- строить гибридные polyglot-архитектуры;
- мигрировать данные из реляционных БД без downtime;
- управлять безопасностью и комплаенсом в распределенных NoSQL контурах.

## Подтипы и сценарии

| Подтип | Что хранит лучше всего | Типовые запросы | Риски |
| --- | --- | --- | --- |
| Document | профили, каталоги, CMS | поиск по атрибутам/вложенным полям | рост сложности при сложных транзакциях |
| Key-value | сессии, кэш, feature flags | чтение по ключу, TTL | отсутствие сложных join/filter |
| Wide-column | события, телеком/лог-потоки | диапазоны по partition+clustering key | сложный data modeling |
| Time-series | метрики и телеметрия | rolling windows, downsampling | неверная cardinality tags |
| Graph | связи и маршруты | shortest path, pattern matching | сложность горизонтального масштабирования |
| Search | тексты и релевантность | full-text, facets, scoring | eventual consistency индекса |

## ACID vs BASE в NoSQL

| Вопрос | Практика |
| --- | --- |
| Нужны ли распределенные ACID-транзакции? | ограниченно, зависит от продукта и конкретной СУБД |
| Где подходит BASE/eventual? | фиды, каталог, рекомендации, кэш |
| Как держать целостность? | idempotency, versioning, compensating actions, outbox/inbox |

## Миграция из реляционной БД

1. Выделить bounded context для пилотной миграции.
2. Определить целевой access pattern и новую модель данных.
3. Настроить dual-write через outbox/CDC.
4. Провести валидацию read-path и консистентности.
5. Переключить трафик поэтапно и оставить rollback окно.

## Безопасность и защита данных

- шифрование at-rest и in-transit;
- RBAC/ABAC и least privilege;
- data masking/tokenization для чувствительных полей;
- аудит операций на уровне платформы и приложения.

## Гибридные и multi-model СУБД

| Система | Что дает |
| --- | --- |
| ArangoDB | graph + document + key-value в одном движке |
| Fauna | serverless распределенная БД с глобальной моделью данных |
| Cosmos DB | multi-model API поверх управляемой cloud платформы |

## Типовые ошибки

- выбирать NoSQL как "быстрее" без анализа запросов;
- не фиксировать модель консистентности для бизнес-сценариев;
- игнорировать key design, что приводит к hot partitions;
- выполнять массовую миграцию без staged rollout.
## Стандарты и источники

- MongoDB docs: <https://www.mongodb.com/docs/>
- Redis docs: <https://redis.io/docs/>
- Cassandra docs: <https://cassandra.apache.org/doc/latest/>
- Neo4j docs: <https://neo4j.com/docs/>
- OpenSearch docs: <https://opensearch.org/docs/latest/>
