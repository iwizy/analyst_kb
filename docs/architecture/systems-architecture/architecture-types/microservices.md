# Микросервисная арх
итектура

Микросервисы разделяют систему на автономные сервисы по business capabilities с независимым деплоем и масштабированием.

## Уровни сложности

### Базовый уровень

- понимать service boundaries и ownership;
- использовать [API](../../../glossary.md#abbr-005)-контракты и события;
- обеспечивать независимый релиз сервисов.

### Средний уровень

- выбирать sync vs async коммуникацию;
- проектировать data ownership (database per service);
- внедрять observability и contract testing.

### Продвинутый уровень

- управлять consistency при network partitions;
- строить platform engineering (gateway, mesh, telemetry);
- эволюционировать архитектуру без distributed monolith.

## Структура

```kroki-plantuml
@startuml
left to right direction
node "API Gateway" as GW
node "Order Service" as ORD
node "Payment Service" as PAY
node "Inventory Service" as INV
queue "Kafka/Pulsar" as BUS
database "Order DB" as ODB
database "Payment DB" as PDB
database "Inventory DB" as IDB
GW --> ORD
GW --> PAY
GW --> INV
ORD --> ODB
PAY --> PDB
INV --> IDB
ORD --> BUS : OrderPlaced
BUS --> PAY : PaymentRequested
BUS --> INV : StockReserved
@enduml
```

## Преимущества

- независимые релизы и масштабирование;
- изоляция ошибок по доменам;
- автономность команд.

## Недостатки

- distributed complexity (latency, timeouts, retries);
- сложнее тестирование e2e;
- рост платформенной стоимости.

## Когда применять

- продукт и домены стабильно растут;
- несколько команд с независимым backlog;
- есть зрелые [CI/CD](../../../glossary.md#abbr-017), SRE, observability.

## Антипаттерны

- distributed monolith (жесткие sync-цепочки);
- shared database across services;
- игнорирование idempotency и versioning.

## Инструментальные trade-off

| Выбор | Когда лучше | Ограничения |
| --- | --- | --- |
| Spring Boot | зрелая экосистема enterprise | тяжелее старт и память |
| Quarkus | быстрый cold start, cloud-native | меньше зрелых enterprise интеграций |
| [REST](../../../glossary.md#abbr-071) | универсальность и простота | overhead payload и latency |
| [gRPC](../../../glossary.md#abbr-036) | эффективный service-to-service | сложнее для внешних клиентов |
| Kafka | высоконагруженный streaming backbone | выше операционная сложность |
| Pulsar | multi-tenant и geo-replication | экосистема уже, чем Kafka |

| Выбор БД | Когда лучше | Ограничения |
| --- | --- | --- |
| PostgreSQL | транзакционность, сложные запросы, строгая консистентность | вертикальные пределы и сложность глобального масштаба |
| Cassandra | massive write, geo-distribution, высокая доступность | сложные ad-hoc запросы и eventual consistency модель |

## Практические рекомендации

1. Декомпозируйте по business capability, не по слоям.
2. У каждого сервиса — свой data owner.
3. Введите контрактные тесты и compatibility policy.
4. Обеспечьте tracing, метрики, лог-корреляцию.
## Стандарты и источники

- Sam Newman, *Building Microservices*.
- Microservices.io patterns: <https://microservices.io/>
- CNCF cloud-native references.
