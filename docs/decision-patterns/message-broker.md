# Шаблон выбора брокера сообщений

Шаблон помогает выбрать транспорт событий и команд: Kafka, RabbitMQ, Pulsar или managed queue.

## Сравнение вариантов

| Критерий | Kafka | RabbitMQ | Pulsar | Managed Queue (SQS/PubSub) |
| --- | --- | --- | --- | --- |
| Потоковые данные и высокий throughput | сильный | средний | сильный | средний |
| Сложная маршрутизация команд | средний | сильный | средний | слабый |
| Replay и долгий retention | сильный | средний | сильный | зависит от сервиса |
| Операционная сложность | высокая | средняя | высокая | низкая |
| Time-to-market | средний | высокий | средний | высокий |

## Рекомендация по умолчанию

- Event backbone и аналитические потоки: Kafka/Pulsar.
- Task queue и сложная маршрутизация: RabbitMQ.
- Если критична скорость запуска и минимальная эксплуатация: managed queue.

## Шаблон решения

```markdown
Контекст:
- Тип сообщений: event/command/task
- Нагрузка: msg/s, размер payload
- Требования к retention/replay

Решение:
- Выбранный брокер:
- Топология (topic/exchange/queue):
- Retry/DLQ стратегия:
- Метрики и алерты:
```

## Пример (media platform)

- Контекст: поток событий просмотров, пиковая нагрузка и долгий retention.
- Решение: Kafka, партиционирование по content_id, отдельные retry/DLQ-топики.
- Метрики: consumer lag, rebalance frequency, error ratio.

## Кросс-ссылки

- [Брокеры сообщений](../integrations/integration-methods/message-brokers/index.md)
- [Kafka](../integrations/integration-methods/message-brokers/kafka.md)
- [RabbitMQ](../integrations/integration-methods/message-brokers/rabbitmq.md)
- [Альтернативные брокеры](../integrations/integration-methods/message-brokers/alternatives.md)
