# Интеграционные паттерны

Интеграционные паттерны задают устойчивую архитектуру взаимодействия сервисов. Ниже собраны паттерны, которые чаще всего применяются в enterprise-проектах.

## Уровни сложности

### Базовый уровень

- различать request/response и publish/subscribe;
- понимать, где нужен синхронный ответ, а где событие;
- фиксировать базовый контракт и ownership.

### Средний уровень

- применять Saga, CQRS и Event-Driven Architecture;
- комбинировать паттерны (например, outbox + pub/sub);
- проектировать компенсации и повторную обработку.

### Продвинутый уровень

- внедрять orchestration/choreography на уровне платформы;
- использовать process manager для сложных потоков;
- управлять сквозной согласованностью в multi-domain системах.

## Request/Response

- **Когда использовать:** нужен немедленный результат (валидация, чтение баланса, синхронное подтверждение).
- **Плюсы:** простота, предсказуемость для клиента.
- **Минусы:** сильная связность, чувствительность к latency downstream.

## Publish/Subscribe

- **Когда использовать:** одно событие должны обработать несколько подписчиков.
- **Плюсы:** слабая связность, масштабируемость.
- **Минусы:** сложнее трассировка и отладка eventual consistency.

## Saga

### Оркестрация

- координатор управляет шагами и компенсациями;
- проще контролировать поток, но создается central coordinator.

### Хореография

- сервисы реагируют на события без центра;
- выше автономность, но сложнее анализировать поток.

```kroki-plantuml
@startuml
participant "Order Service" as O
participant "Payment Service" as P
participant "Inventory Service" as I
participant "Notification Service" as N

O -> P: Reserve payment
P --> O: Reserved
O -> I: Reserve items
alt stock ok
  I --> O: Reserved
  O -> N: Publish OrderConfirmed
else stock fail
  I --> O: Failed
  O -> P: Compensation CancelPayment
  O -> N: Publish OrderRejected
end
@enduml
```

## CQRS

- разделение командной и запросной моделей;
- полезно при разных профилях write/read нагрузки;
- требует стратегии синхронизации read model.

## Event-Driven Architecture

- события фиксируют значимые бизнес-факты;
- подписчики обрабатывают их независимо;
- важно определить schema evolution и replay policy.

## Дополнительные паттерны

| Паттерн | Суть | Пример |
| --- | --- | --- |
| Aggregator | собирает данные из нескольких источников | BFF собирает профиль клиента |
| Splitter | делит большой запрос на части | batch платежей на отдельные операции |
| Claim Check | хранит payload вне шины, передает ссылку | большие документы в object storage |
| Service Bus | централизованный транспорт/маршрутизация | legacy ESB контур |
| Command pattern | явные команды вместо вызовов CRUD | `ApproveLoan`, `ShipOrder` |
| Transactional Outbox | событие публикуется из надежной outbox | заказ + событие `OrderCreated` |
| Process Manager | управляет длительным бизнес-процессом | заявка с многими проверками |

## Orchestration vs Choreography

| Критерий | Orchestration | Choreography |
| --- | --- | --- |
| Управление процессом | централизованное | распределенное |
| Наблюдаемость | проще | сложнее |
| Связность | выше к оркестратору | ниже, но сложнее governance |
| Когда выбирать | критичные транзакционные процессы | события между автономными доменами |

## Инструменты

- Apache Camel, Spring Integration, Camel K;
- Temporal/Zeebe для process orchestration;
- NServiceBus/MassTransit для .NET экосистемы;
- Kafka/Pulsar/NATS для event backbone.

## Типичные ошибки

- выбор паттерна без оценки консистентности и компенсаций;
- отсутствие owner у событий и схем;
- скрытые side-effects без idempotency;
- смешение orchestration и choreography без явных границ.

## Контрольные вопросы

1. Где в вашем процессе обязательна транзакционность, а где допустима компенсация?
2. Кто владеет каждым событием и его schema evolution?
3. Есть ли process manager для долгих межсервисных процессов?
4. Как диагностируется цепочка событий end-to-end?

## Чек-лист самопроверки

- паттерн выбран по бизнес-сценарию и рискам;
- определены компенсации и SLA обработки;
- ownership событий и контрактов закреплен;
- предусмотрены idempotency и replay-стратегии;
- наблюдаемость и audit для потока реализованы.

## Стандарты и источники

- Enterprise Integration Patterns: <https://www.enterpriseintegrationpatterns.com/>
- Saga pattern: <https://microservices.io/patterns/data/saga.html>
- Transactional Outbox: <https://microservices.io/patterns/data/transactional-outbox.html>
