# Брокеры сообщений

Брокеры сообщений обеспечивают асинхронную интеграцию, выравнивание нагрузки и decoupling между сервисами.

## Уровни сложности

### Базовый уровень

- понимать роли producer, broker, consumer;
- выбирать между очередями и логом событий;
- проектировать базовую retry/DLQ стратегию.

### Средний уровень

- настраивать partitioning/routing и consumer groups;
- управлять schema evolution;
- обеспечивать идемпотентность и упорядочивание.

### Продвинутый уровень

- проектировать multi-region messaging;
- управлять exactly-once, replay и governance схем;
- выстраивать платформу событий для многих доменов.

## Kafka vs RabbitMQ

| Критерий | Kafka | RabbitMQ |
| --- | --- | --- |
| Модель | распределенный commit log | брокер очередей/маршрутизации |
| Сильная сторона | throughput, replay, streaming | гибкая маршрутизация и простая очередная семантика |
| Упорядочивание | внутри partition | внутри queue |
| Типовые кейсы | event backbone, аналитика, интеграция доменов | task queues, command messaging, workflow |

## Delivery semantics

| Семантика | Когда нужна | Как достигается |
| --- | --- | --- |
| At-most-once | допускается потеря, но не дубли | commit до обработки |
| At-least-once | потеря недопустима | retry + idempotent consumer |
| Exactly-once | критичные финансовые/регистрационные операции | transactional producer/consumer + idempotency |

## Альтернативы

| Решение | Когда выбирать |
| --- | --- |
| NATS | легковесный request/reply и pub/sub |
| Pulsar | geo-replication, tiered storage, multi-tenancy |
| Amazon SQS | managed очередь в AWS |
| Google Pub/Sub | managed messaging в GCP |
| Azure Service Bus | enterprise messaging в Azure |

## Переход к подразделам

- [Kafka](kafka.md)
- [RabbitMQ](rabbitmq.md)
## Стандарты и источники

- Kafka docs: <https://kafka.apache.org/documentation/>
- RabbitMQ docs: <https://www.rabbitmq.com/documentation.html>
- CloudEvents spec: <https://cloudevents.io/>
