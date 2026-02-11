# Типы баз данных
Раздел помогает выбрать тип БД на основе транзакционных требований, профиля запросов, [CAP](../../glossary.md#abbr-013)/[PACELC](../../glossary.md#abbr-061)-компромиссов и эксплуатационных ограничений.

## Уровни сложности

### Базовый уровень

- различать реляционные, NoSQL, NewSQL, ledger и multi-model;
- выбирать тип БД по доминирующему сценарию доступа.

### Средний уровень

- оценивать trade-off между консистентностью, доступностью и задержкой;
- проектировать связку нескольких хранилищ под разные нагрузки.

### Продвинутый уровень

- комбинировать distributed [SQL](../../glossary.md#abbr-084), HTAP, search и vector storage;
- управлять стоимостью и сложностью multi-database архитектур.

## Расширенная карта типов

| Класс | Подтип | Сильные стороны | Ограничения | Примеры |
| --- | --- | --- | --- | --- |
| Реляционные | [OLTP](../../glossary.md#abbr-060) SQL | ACID, SQL, строгая целостность | сложнее scale-out | PostgreSQL, MySQL, Oracle |
| NewSQL | Distributed SQL | SQL + горизонтальное масштабирование + согласованность | сложнее эксплуатация | Spanner, CockroachDB, YugabyteDB, TiDB |
| NewSQL | [HTAP](../../glossary.md#abbr-104) | совмещение транзакций и near-real-time аналитики | высокая стоимость и сложность модели | SingleStore, TiDB HTAP |
| NoSQL | Document | гибкая схема, быстрое развитие домена | сложные аналитические join-сценарии | MongoDB, Couchbase |
| NoSQL | Key-value | очень низкая задержка | ограниченные ad-hoc запросы | Redis, DynamoDB |
| NoSQL | Wide-column | высокая write throughput | сложнее модель и запросы | Cassandra, ScyllaDB |
| NoSQL | Time-series | эффективное хранение метрик и событий | узкая специализация | InfluxDB, TimescaleDB |
| NoSQL | Graph | естественная модель связей | не универсальна для OLTP отчетов | Neo4j, JanusGraph |
| NoSQL | Search | полнотекст, релевантность, агрегации | не замена primary transactional store | OpenSearch, Elasticsearch |
| Multi-model | Document + Graph + KV | меньше интеграций между отдельными БД | vendor lock-in, сложнее тюнинг | ArangoDB, Cosmos DB |
| Distributed Ledger | permissioned/public DLT | неизменяемый журнал и межорганизационное доверие | высокая сложность и latency | Hyperledger Fabric, Ethereum |
| Специализированные | Vector DB | similarity search для AI и RAG | ограниченная транзакционность | Milvus, Weaviate, pgvector |

## Критерии выбора

| Критерий | Вопрос | Рекомендуемый фокус |
| --- | --- | --- |
| Транзакции | Нужны ли multi-row/multi-table ACID инварианты? | Реляционная / distributed SQL |
| [Консистентность](../../glossary.md#term-040) | Допустима ли eventual consistency? | NoSQL для non-critical reads |
| Скорость записи | Есть ли постоянный high write ingestion? | Wide-column / TSDB / log storage |
| Сложность запросов | Нужны сложные join/window/CTE? | SQL-системы |
| CAP-компромисс | Что важнее при partition: C или A? | CP для финтеха, AP для feed/caching |
| Latency | Какие p95/p99 цели? | KV/cache/search near users |
| Операционная зрелость | Есть ли экспертиза поддержки кластера? | выбирать manageable stack |

## PACELC-ориентированный выбор

| Профиль | При partition | Без partition | Типовые системы |
| --- | --- | --- | --- |
| CP/EL (консистентность и latency не критична) | C > A | C > L | Spanner, CockroachDB |
| AP/EL (доступность и write throughput) | A > C | L > C | Cassandra, DynamoDB |
| Гибридный | по доменам отдельно | по [SLA](../../glossary.md#abbr-079) слоя | Polyglot architecture |

## Паттерны сочетания хранилищ

| [Паттерн](../../glossary.md#term-052) | Состав | Сценарий |
| --- | --- | --- |
| Transaction + Cache | PostgreSQL + Redis | e-commerce checkout + быстрые карточки |
| Transaction + Search | MySQL/PostgreSQL + OpenSearch | каталоги и полнотекст |
| SQL + TSDB | PostgreSQL + TimescaleDB | IoT platform (события + мастер-данные) |
| OLTP + [DWH](../../glossary.md#abbr-029) | OLTP DB + ClickHouse/Redshift | управленческая аналитика и [BI](../../glossary.md#abbr-008) |
| Core DB + Ledger | SQL + Hyperledger | аудитируемые бизнес-процессы в госсекторе |

## Типовые ошибки

- выбор NoSQL без явной модели целостности;
- игнорирование read/write ratio и hot partitions;
- попытка выполнять BI-нагрузку на production OLTP;
- отсутствие ownership и SLA по каждой БД в polyglot-архитектуре.

## Практические рекомендации

1. Декомпозируйте данные по bounded contexts и паттернам доступа.
2. Для каждого storage определите [SLO](../../glossary.md#abbr-081), владельца и границы ответственности.
3. Документируйте CAP/PACELC-компромиссы в архитектурных решениях.
4. Добавьте сценарии миграции и graceful degradation заранее.
## Стандарты и источники

- CAP paper: <https://dl.acm.org/doi/10.1145/564585.564601>
- PACELC: <https://ieeexplore.ieee.org/document/6133253>
- PostgreSQL docs: <https://www.postgresql.org/docs/>
- MongoDB docs: <https://www.mongodb.com/docs/>
- CockroachDB architecture: <https://www.cockroachlabs.com/docs/stable/architecture/overview>
- YugabyteDB architecture: <https://docs.yugabyte.com/>

## Переход к подразделам

- [Реляционные базы данных](relational.md)
- [NoSQL базы данных](nosql/index.md)
- [NewSQL базы данных](newsql.md)
- [Консистентность и распределение](../consistency-and-distribution.md)
- [Практические примеры выбора БД](../practical-cases.md)
