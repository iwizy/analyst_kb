# Kafka

> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)


Kafka подходит для high-throughput event streaming, replay и интеграции большого количества сервисов через устойчивый журнал событий.

## Уровни сложности

### Базовый уровень

- понимать `topic`, `partition`, `offset`;
- настраивать producer/consumer и consumer groups;
- контролировать lag и базовый retry.

### Средний уровень

- применять idempotent producer и transactional processing;
- использовать schema registry (Avro/Protobuf);
- оптимизировать partition keys и retention.

### Продвинутый уровень

- строить multi-region кластеры;
- внедрять exactly-once semantics и stream processing;
- управлять горячими партициями и cost/performance балансом.

## Архитектура

| Компонент | Назначение |
| --- | --- |
| Topic | логическая категория событий |
| Partition | масштабирование и параллелизм |
| Segment | файл хранения внутри partition |
| Broker | узел кластера, хранит партиции |
| Controller | управляет лидерами и состоянием кластера |
| Consumer Group | конкурентное чтение с partition assignment |

## Поток обработки

```kroki-plantuml
@startuml
actor Producer
queue "Kafka Topic" as T
participant "Consumer Group A" as C
database "DLQ Topic" as D

Producer -> T: publish event
C -> T: poll batch
alt processing ok
  C -> C: commit offset
else processing failed
  C -> D: publish failed event
end
@enduml
```

## Ключевые настройки producer

| Параметр | Рекомендация |
| --- | --- |
| `acks` | `all` для надежной записи |
| `enable.idempotence` | `true` для защиты от дубликатов |
| `retries` | >0 с backoff |
| `compression.type` | `lz4`/`zstd` для баланса CPU/size |
| `max.in.flight.requests.per.connection` | аккуратно при строгом порядке |

## Exactly-once semantics (EOS)

- idempotent producer исключает дубли при ретраях;
- transactional producer связывает запись в несколько топиков и offset commit;
- consumer должен быть transaction-aware.

## Schema evolution

- используйте Schema Registry;
- задайте policy: backward/forward/full compatibility;
- не удаляйте и не переиспользуйте критичные поля без миграции.

## Stream processing

- Kafka Streams/Flink для stateful обработки;
- materialized state stores для агрегаций;
- checkpointing и replay для восстановления.

## Анти-паттерны

- hot partition из-за плохого partition key;
- oversized messages вместо claim-check;
- unbounded retention без потребности replay;
- commit offset до завершения обработки.

## Мониторинг

| Метрика | Зачем |
| --- | --- |
| consumer lag | признак отставания обработки |
| rebalance frequency | стабильность consumer groups |
| produce/consume rate | throughput и capacity planning |
| under-replicated partitions | риск потери устойчивости |
| request latency | деградация кластера/сети |

## Пример offset management

- at-least-once: commit после успешной обработки;
- batch processing: commit после батча;
- при ошибке: отправка в DLQ + commit либо stop (по policy).
## Стандарты и источники

- Kafka docs: <https://kafka.apache.org/documentation/>
- Confluent EOS guide: <https://docs.confluent.io/platform/current/streams/concepts.html>
- Kafka Streams docs: <https://kafka.apache.org/documentation/streams/>
