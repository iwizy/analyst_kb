# Синх
ронное и асинхронное взаимодействие

Выбор между sync request/response и async messaging определяет latency, устойчивость и модель консистентности системы.

## Уровни сложности

### Базовый уровень

- различать sync и async взаимодействие;
- понимать [SLA](../../glossary.md#abbr-079) и ожидания клиента;
- учитывать идемпотентность.

### Средний уровень

- выбирать transport ([REST](../../glossary.md#abbr-071)/[gRPC](../../glossary.md#abbr-036)/queue/event bus);
- проектировать retry, timeout и delivery semantics;
- учитывать eventual consistency.

### Продвинутый уровень

- комбинировать sync и async в одном процессе;
- проектировать compensation и saga-потоки;
- управлять p95/p99 latency на distributed цепочках.

## Сравнение подходов

| Критерий | Синхронный | Асинхронный |
| --- | --- | --- |
| Ответ клиенту | сразу | отложенный/по событию |
| Задержка | ниже при короткой цепочке | выше, но стабильнее под пиком |
| Надежность под нагрузкой | риск каскадных таймаутов | буферизация через брокер |
| [Консистентность](../../glossary.md#term-040) | проще сильная | чаще eventual |
| Сложность | ниже | выше (replay, dedup, lag) |

## Sequence: sync request/response

```kroki-plantuml
@startuml
actor Client
participant API
participant Payment
Client -> API: POST /checkout
API -> Payment: authorize()
Payment --> API: approved
API --> Client: 201 Created
@enduml
```

## Sequence: async event flow

```kroki-plantuml
@startuml
actor Client
participant API
queue Bus
participant Inventory
participant Notification
Client -> API: POST /order
API --> Client: 202 Accepted
API -> Bus: OrderPlaced
Bus -> Inventory: reserve
Bus -> Notification: send confirmation
@enduml
```

## Как выбирать стратегию

1. Нужен ли ответ пользователю немедленно?
2. Допустима ли eventual consistency?
3. Есть ли риск пиковой нагрузки и очередей?
4. Какие гарантии доставки нужны (at-most/at-least/exactly once)?

## Практические правила

- Sync: ставьте timeout budget, circuit breaker, fallback.
- Async: обеспечьте idempotency key, DLQ, retry with backoff.
- Для критичных операций комбинируйте: sync-подтверждение + async-обработка.

## Технологические сравнения

| Выбор | Когда лучше | Ограничения |
| --- | --- | --- |
| [REST](../../glossary.md#abbr-071) | внешние [API](../../glossary.md#abbr-005) и простота | overhead payload |
| [gRPC](../../glossary.md#abbr-036) | service-to-service low latency | сложнее browser integration |
| Kafka | высокий throughput streaming | операционная сложность |
| Pulsar | geo-replication и multi-tenant | меньше зрелых практик |

Кросс-ссылка: [Интеграции: паттерны взаимодействия](../../integrations/integration-methods/patterns.md).

## Типичные ошибки

- длинные sync-цепочки без timeout budget;
- retry non-idempotent операции;
- отсутствие lag-мониторинга у async consumer;
- смешение command и event semantics.
## Стандарты и источники

- Enterprise Integration Patterns.
- gRPC docs: <https://grpc.io/docs/>
- [RFC](../../glossary.md#abbr-072) 9110 [HTTP](../../glossary.md#abbr-038) Semantics.
