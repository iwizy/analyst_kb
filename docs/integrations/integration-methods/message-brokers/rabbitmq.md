# RabbitMQ

RabbitMQ это брокер сообщений на базе AMQP с гибкой маршрутизацией и надежной доставкой через ack/requeue/DLQ.

## Базовые сущности

- exchange (`direct`, `topic`, `fanout`, `headers`);
- queue;
- binding;
- producer;
- consumer;
- ack/nack.

## Поток

```kroki-plantuml
@startuml
participant Producer
participant Exchange
queue QueueA
queue QueueB
participant Consumer

Producer -> Exchange: publish(routing_key)
Exchange -> QueueA: route
Exchange -> QueueB: route
QueueA -> Consumer: deliver
Consumer --> QueueA: ack
@enduml
```

## Когда выбирать RabbitMQ

- command/task queues;
- сложная маршрутизация сообщений;
- приоритеты, TTL, DLQ и fine-grained control;
- умеренные объемы при высоких требованиях к delivery control.

## Достоинства

- гибкая маршрутизация;
- удобные механики ack/retry/dead-letter;
- зрелый tooling для enterprise задач.

## Ограничения

- меньше throughput, чем у Kafka в stream-heavy сценариях;
- требует аккуратной настройки при росте кластера;
- порядок сообщений зависит от модели очередей/консюмеров.

## Практические рекомендации

- использовать manual ack для критичных обработчиков;
- настраивать DLX/DLQ и retry policy;
- ограничивать prefetch для consumer fairness;
- контролировать unacked messages и queue depth.

## Смежные материалы

- [Паттерны надежности](../reliability-patterns.md)
- [Обмен файлами](../file-exchange.md)
