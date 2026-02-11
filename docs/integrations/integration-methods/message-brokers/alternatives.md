# Pulsar, NATS, SQS, Pub/Sub, Service Bus

Этот материал дополняет Kafka/RabbitMQ и помогает выбрать брокер под конкретный профиль интеграции: latency, ordering, replay, эксплуатация и стоимость.

## Уровни сложности

### Базовый уровень

- понимать сильные стороны managed и self-hosted брокеров;
- выбирать между queue и log-подходом;
- учитывать retry/DLQ и delivery semantics.

### Средний уровень

- проектировать multi-tenant и geo-сценарии;
- выбирать модель хранения и retention;
- настраивать SLA для producer/consumer контуров.

### Продвинутый уровень

- строить event backbone c несколькими классами трафика;
- управлять стоимостью хранения/трафика и cross-region replication;
- внедрять schema governance и replay policies.

## Сравнение альтернатив

| Платформа | Сильные стороны | Ограничения | Когда выбирать |
| --- | --- | --- | --- |
| Apache Pulsar | topic-level tiered storage, geo-replication, multi-tenant namespaces | выше операционная сложность, чем у managed решений | крупные event-платформы и multi-region |
| NATS / JetStream | очень низкая latency, простота request/reply, легковесность | меньше привычных enterprise-паттернов из Kafka-мира | микросервисы, control-plane события |
| Amazon SQS | fully managed queue, минимальные ops | ограниченная логика стриминга и replay | AWS workloads, task processing |
| Google Pub/Sub | managed pub/sub, auto scale, deep GCP integration | меньше гибкости low-level tuning | GCP-native event integration |
| Azure Service Bus | enterprise queues/topics, интеграция с Azure | cost и лимиты при сверхвысокой нагрузке | enterprise в Azure, B2B workflows |

## Архетипы сценариев

| Сценарий | Рекомендуемый класс брокера |
| --- | --- |
| Высокий throughput + replay на месяцы | Kafka/Pulsar |
| Быстрые команды между сервисами | RabbitMQ/NATS |
| Managed task queue без ops-команды | SQS/Service Bus |
| Cloud-native eventing в GCP | Pub/Sub |

## Multi-region и хранение

| Вопрос | Pulsar | NATS | SQS/PubSub/Service Bus |
| --- | --- | --- | --- |
| Geo-replication | встроенная модель namespaces/replication | требует отдельной архитектуры | зависит от managed feature set |
| Tiered storage | встроен (bookkeeper + offload) | ограниченно в сравнении | провайдер-зависимо |
| Replay исторических событий | сильная сторона | ограничено retention-моделью | ограничено политикой сервиса |

## Практика выбора

1. Зафиксируйте класс нагрузки: command, event-stream, batch.
1. Определите требования к ordering, replay horizon и retention.
1. Оцените зрелость команды по эксплуатации self-hosted решений.
1. Сравните TCO: infra + ops + incident handling.
1. Примите решение в ADR с миграционным планом и fallback.

## Типовые ошибки

- выбор брокера по популярности вместо профиля нагрузки;
- смешение task queue и event log в одном контуре без границ;
- отсутствие SLA на lag/retry/DLQ;
- недооценка стоимости egress и хранения в multi-region.

## Практические рекомендации

1. Разделяйте контуры `event backbone` и `операционные команды`.
2. Для managed сервисов фиксируйте лимиты и деградационный план.
3. Для self-hosted брокеров обязательно планируйте capacity + DR drills.
4. Внедряйте единый стандарт schema evolution независимо от брокера.
## Стандарты и источники

- Apache Pulsar docs: <https://pulsar.apache.org/docs/>
- NATS docs: <https://docs.nats.io/>
- Amazon SQS docs: <https://docs.aws.amazon.com/sqs/>
- Google Pub/Sub docs: <https://cloud.google.com/pubsub/docs>
- Azure Service Bus docs: <https://learn.microsoft.com/azure/service-bus-messaging/>
