# [Консистентность](../glossary.md#term-040) и распределение

Раздел объясняет, как выбирать и документировать компромиссы в распределенных базах данных: от ACID/BASE до [CAP](../glossary.md#abbr-013)/[PACELC](../glossary.md#abbr-061), репликации и конфликтов.

## Уровни сложности

### Базовый

- понимать различия ACID и BASE;
- ориентироваться в CAP-теореме и eventual consistency.

### Средний

- выбирать модель консистентности (strong, causal, eventual) под домен;
- проектировать leader/follower, quorum и multi-leader схемы.

### Продвинутый

- управлять конфликтами при partition и multi-region;
- применять compensation patterns, idempotency и conflict resolution.

## ACID, BASE, CAP, PACELC

| Модель | Ключевая идея | Когда применять |
| --- | --- | --- |
| ACID | корректность транзакций и инвариантов | платежи, биллинг, учет |
| BASE | доступность и масштаб, консистентность позже | каталоги, рекомендации, feed |
| CAP | при partition выбираем C или A | распределенные системы с сетевыми сбоями |
| PACELC | без partition баланс latency и consistency | multi-region high load платформы |

## Модели консистентности

| Модель | Гарантия | Пример |
| --- | --- | --- |
| Strong | каждый read видит последнее write | платежный баланс |
| Causal | причинно связанные операции в порядке | чат/коллаборация |
| Eventual | состояние сходится со временем | кэш, поиск, аналитический индекс |

## Уровни изоляции и аномалии

| Уровень | Предотвращает | Возможные аномалии |
| --- | --- | --- |
| Read Committed | dirty read | lost update/non-repeatable |
| Repeatable Read | non-repeatable | phantom (зависит от СУБД) |
| Serializable | основные аномалии конкурентности | рост конфликтов/latency |

## Алгоритмы репликации

| Подход | Плюсы | Минусы | Типовые системы |
| --- | --- | --- | --- |
| Leader/Follower | простой write path, предсказуемость | lag на репликах | PostgreSQL, MySQL |
| Multi-leader | локальные write в нескольких DC | конфликт-резолвинг сложнее | CouchDB, некоторые enterprise setups |
| Quorum (R/W/N) | гибкая консистентность/доступность | сложнее тюнинг и дебаг | Cassandra, Dynamo-like |
| Gossip | масштабируемый обмен состоянием | eventual convergence, сложная диагностика | Cassandra, Consul |

## Схема trade-off

```kroki-plantuml
@startuml
left to right direction
rectangle "Consistency" as C
rectangle "Availability" as A
rectangle "Partition tolerance" as P
rectangle "Latency" as L

C -- P : CAP
A -- P : CAP
C -- L : PACELC
A -- L : PACELC
@enduml
```

## Практические конфликты и решения

### Lost Update

Сценарий: два процесса читают одну запись и перезаписывают друг друга.

Решение:

- optimistic locking (`version`);
- `SELECT ... FOR UPDATE` для критичных транзакций;
- idempotent write operations.

### Double Spend

Сценарий: конкурентные транзакции списывают один и тот же остаток.

Решение:

- serializable/strict transaction boundaries;
- условные обновления (`WHERE balance >= amount`);
- ledger-pattern с неизменяемыми проводками.

### Conflict в multi-leader

Сценарий: два региона изменили один объект параллельно.

Решение:

- deterministic conflict resolution (LWW, vector clocks, domain rules);
- CRDT для подходящих типов данных;
- compensation workflow для бизнес-критичных операций.

## Техники компенсации

- Saga orchestration/choreography;
- outbox/inbox pattern для надежной доставки событий;
- идемпотентные [API](../glossary.md#abbr-005) и deduplication keys;
- reconciliation jobs и audit trails.

## Типовые ошибки

- считать [CAP](../glossary.md#abbr-013) выбором "на всю систему", а не на конкретный поток;
- не фиксировать consistency requirements в требованиях;
- использовать eventual consistency в финансовом инварианте;
- не тестировать partition и региональные сбои.

## Практические рекомендации

1. Формулируйте требования к консистентности на уровне каждого бизнес-сценария.
2. Добавляйте chaos/partition tests в pre-production.
3. Явно документируйте fallback поведение при lag и split network.
4. Для high-risk потоков выбирайте простые и проверяемые модели.
## Стандарты и источники

- CAP paper: <https://dl.acm.org/doi/10.1145/564585.564601>
- [PACELC](../glossary.md#abbr-061) paper: <https://ieeexplore.ieee.org/document/6133253>
- Designing Data-Intensive Applications (Kleppmann): <https://dataintensive.net/>
- PostgreSQL transaction isolation: <https://www.postgresql.org/docs/current/transaction-iso.html>
- Jepsen analyses: <https://jepsen.io/analyses>
