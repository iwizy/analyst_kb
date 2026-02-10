# Паттерны надежности

Надежность интеграций достигается комбинацией технических паттернов и наблюдаемости.

## Retry

Повтор запроса при временных ошибках.

Правила:

- только для retryable ошибок;
- exponential backoff + jitter;
- лимит числа попыток.

## Timeout

Ограничивает время ожидания ответа, предотвращает зависание ресурсов.

## Circuit Breaker

Размыкает вызовы к деградировавшему сервису и защищает систему от cascade failure.

## Bulkhead

Изолирует ресурсы по пулам, чтобы отказ одного направления не погасил весь сервис.

## Dead Letter Queue (DLQ)

Сообщения, не прошедшие обработку, отправляются в отдельный канал для ручного/автоматического разбора.

## Outbox/Inbox

- Outbox: транзакционная публикация событий вместе с изменением БД.
- Inbox: дедупликация входящих событий по message-id.

## Поток с retry + breaker

```kroki-plantuml
@startuml
actor Client
participant ServiceA
participant ServiceB

Client -> ServiceA: request
ServiceA -> ServiceB: call (attempt 1)
ServiceB --> ServiceA: timeout
ServiceA -> ServiceB: retry (backoff)
ServiceB --> ServiceA: fail
ServiceA -> ServiceA: circuit opens
ServiceA --> Client: fallback response
@enduml
```

## Практические рекомендации

- задать timeout короче SLA вызывающего сервиса;
- не делать бесконечные retry;
- логировать attempt number и reason;
- измерять error budget и retry-storm метрики.

## Смежные материалы

- [Интеграционные паттерны](patterns.md)
- [Идемпотентность](../api-design/idempotency.md)
- [Брокеры сообщений](message-brokers/index.md)
