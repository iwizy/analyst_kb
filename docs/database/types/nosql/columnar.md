# Колоночные NoSQL (Wide-Column)

Wide-column СУБД оптимизированы под большие потоки записи и масштабирование на кластере из множества узлов.

## Уровни сложности

### Базовый уровень

- понимать partition key и clustering columns;
- проектировать модель "по запросам".

### Средний уровень

- управлять replication factor и consistency levels;
- учитывать hot partitions и compaction.

### Продвинутый уровень

- проектировать multi-DC топологию и repair-процессы;
- оптимизировать storage/latency на петабайтных объемах.

## Где применять

- event ingestion, clickstream;
- телеком/IoT с постоянной записью;
- логовые и временные агрегаты в реальном времени.

## Пример CQL-модели

```sql
CREATE TABLE device_metrics (
  device_id TEXT,
  day DATE,
  ts TIMESTAMP,
  temperature DOUBLE,
  voltage DOUBLE,
  PRIMARY KEY ((device_id, day), ts)
) WITH CLUSTERING ORDER BY (ts DESC);
```

Пояснение:

- `(device_id, day)` — partition key, ограничивает размер партиции;
- `ts` — clustering key, обеспечивает порядок чтения последних значений.

## ACID/BASE и консистентность

- обычно AP-профиль с настраиваемыми уровнями консистентности (`ONE`, `QUORUM`, `ALL`);
- целостность чаще обеспечивается на уровне приложения и event semantics.

## Безопасность

- [TLS](../../../glossary.md#abbr-088) inter-node/client-node;
- role-based authorization;
- шифрование данных на диске;
- аудит изменений схемы и админ-операций.

## [Миграция](../../../glossary.md#term-045) из [SQL](../../../glossary.md#abbr-084)

1. Для каждого отчета/эндпоинта сформировать отдельную denormalized таблицу.
2. Выбрать partition key, предотвращающий hot spots.
3. Настроить dual-write и сравнение бизнес-метрик.
4. Внедрить repair и anti-entropy процедуры.

## Типовые ошибки

- попытка делать ad-hoc SQL-style join;
- слишком крупные партиции;
- неверный replication factor;
- отсутствие контроля compaction и tombstones.

## Практические рекомендации

1. Начинайте проектирование с query-first подхода.
2. Ограничивайте размер партиции по времени/тенанту.
3. Выбирайте consistency level по критичности сценария.
4. Планируйте регулярный repair в операционном календаре.
## Стандарты и источники

- Apache Cassandra docs: <https://cassandra.apache.org/doc/latest/>
- ScyllaDB docs: <https://opensource.docs.scylladb.com/>
