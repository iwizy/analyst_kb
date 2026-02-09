# Брокеры сообщений

Брокеры сообщений обеспечивают асинхронное взаимодействие между сервисами, снижая связность и повышая устойчивость системы.

## Когда использовать брокер

- нужно decouple producer и consumer;
- необходима буферизация пиков;
- требуется fan-out событий;
- важна retry/DLQ стратегия.

## Kafka vs RabbitMQ (кратко)

| Критерий | Kafka | RabbitMQ |
| --- | --- | --- |
| Модель | distributed log | message broker с очередями/exchange |
| Сильная сторона | high throughput, stream processing | гибкая маршрутизация и подтверждения |
| Типичный кейс | event streaming, analytics pipeline | task queue, командные интеграции |

## Delivery semantics

- at-most-once;
- at-least-once;
- exactly-once (частично и контекстно, зависит от платформы/дизайна).

## Переход к подразделам

- [Kafka](kafka.md)
- [RabbitMQ](rabbitmq.md)
