# Event Sourcing и CQRS

Event Sourcing и CQRS часто применяются вместе, но решают разные задачи.

## CQRS

Command Query Responsibility Segregation разделяет модель записи и модель чтения.

- `Command side`: валидация и изменение состояния.
- `Query side`: оптимизированное чтение и отчеты.

## Event Sourcing

Состояние не хранится «как есть», а восстанавливается из потока событий (`OrderCreated`, `PaymentAuthorized`, `OrderShipped`).

## Когда это оправдано

- нужен полный audit trail бизнес-событий;
- сложная доменная логика и высокая нагрузка на чтение;
- требуются разные read-модели для разных потребителей.

## Пример потока

```kroki-plantuml
@startuml
left to right direction
actor User
rectangle "Command API" as Cmd
rectangle "Aggregate" as Agg
database "Event Store" as ES
queue "Event Bus" as Bus
database "Read Model" as RM
rectangle "Query API" as Query

User --> Cmd : create order
Cmd --> Agg
Agg --> ES : append events
ES --> Bus : publish events
Bus --> RM : project
User --> Query : get order view
Query --> RM
@enduml
```

## Плюсы

- прозрачная история изменений;
- высокая гибкость read-моделей;
- сильная трассировка и воспроизводимость.

## Минусы

- высокая архитектурная сложность;
- необходимость управления версиями событий;
- усложнение отладки и миграций.

## Типичные ошибки

- использовать ES/CQRS «на вырост» в простом CRUD-домене;
- не управлять schema evolution событий;
- игнорировать мониторинг lag read-модели.
