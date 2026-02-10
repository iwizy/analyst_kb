# Event-Driven и Serverless

Event-Driven Architecture (EDA) и serverless/FaaS усиливают слабую связность и эластичность, но требуют строгой дисциплины по событиям, идемпотентности и observability.

## Уровни сложности

### Базовый уровень

- понимать событие как факт домена;
- отличать event notification и event-carried state;
- знать основы FaaS и managed runtimes.

### Средний уровень

- проектировать event contracts и schema evolution;
- выбирать брокер и delivery semantics;
- учитывать cold start и ограничения времени выполнения функций.

### Продвинутый уровень

- строить event backbone с governance;
- оптимизировать throughput/latency/cost;
- управлять консистентностью и replay-processing.

## Схема EDA + serverless

```kroki-plantuml
@startuml
left to right direction
rectangle "Producer Service" as P
queue "Event Bus" as B
rectangle "FaaS Handler A" as F1
rectangle "FaaS Handler B" as F2
database "Read Model" as R
P --> B : OrderPlaced
B --> F1 : trigger
B --> F2 : trigger
F1 --> R
F2 --> R
@enduml
```

## Преимущества

- эластичность под burst-нагрузку;
- слабая связанность между компонентами;
- быстрое внедрение event-driven фич.

## Недостатки

- сложнее трассировка end-to-end;
- cold starts и лимиты runtime;
- риск event storm и дубликатов сообщений.

## Когда применять

- асинхронные сценарии: уведомления, enrichment, интеграции;
- нерегулярные всплески нагрузки;
- pay-per-use модель вычислений.

## Антипаттерны

- event без owner и schema governance;
- heavy stateful logic в FaaS;
- отсутствие idempotency и dedup.

## Практические рекомендации

1. Проектируйте schema versioning и compatibility policy.
2. Внедряйте DLQ/retry с backoff.
3. Для критичных операций добавляйте outbox/inbox.
4. Свяжите практики с [разделом интеграций](../../../integrations/integration-methods/patterns.md).
## Стандарты и источники

- CloudEvents spec: <https://cloudevents.io/>
- AWS/Azure/GCP serverless architecture guides.
- Event-driven architecture references (Fowler, EIP).
