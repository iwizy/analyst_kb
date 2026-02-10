# Event Sourcing и [CQRS](../../glossary.md#abbr-020)

CQRS и Event Sourcing — enterprise-паттерны для доменов с высоким требованием к auditability, масштабируемому чтению и сложной доменной логике.

## Уровни сложности

### Базовый уровень

- понимать разницу CQRS и Event Sourcing;
- различать command model и query model;
- знать когда это избыточно.

### Средний уровень

- проектировать event schema и read-model projections;
- управлять versioning событий;
- внедрять идемпотентность и replay.

### Продвинутый уровень

- строить multi-model query слой;
- управлять lag и consistency между write/read;
- применять snapshotting и migration strategy.

## CQRS

- `Command side`: команды, инварианты, запись.
- `Query side`: оптимизированные read-модели.
- Выгода: масштабирование чтения, независимая эволюция read [API](../../glossary.md#abbr-005).

## Event Sourcing

- состояние агрегата восстанавливается из последовательности событий;
- append-only журнал событий как source of truth;
- можно воспроизводить историю и строить новые проекции.

## Поток ES + CQRS

```kroki-plantuml
@startuml
left to right direction
actor User
rectangle "Command API" as CMD
rectangle "Aggregate" as AGG
database "Event Store" as ES
queue "Event Bus" as BUS
database "Read Model" as RM
rectangle "Query API" as Q
User --> CMD : command
CMD --> AGG
AGG --> ES : append events
ES --> BUS : publish
BUS --> RM : project
User --> Q : query
Q --> RM
@enduml
```

## Преимущества

- полный audit trail;
- гибкие read-модели;
- высокая трассируемость изменений.

## Недостатки

- сложная ментальная модель;
- schema evolution событий;
- рост операционных требований к monitoring и replay.

## Когда применять

- финтех/регуляторные домены с аудитом;
- сложный жизненный цикл сущностей;
- разные требования к read/write нагрузке.

## Когда не применять

- простой [CRUD](../../glossary.md#abbr-021) без сложных инвариантов;
- маленькая команда без опыта event-driven;
- отсутствие требований к истории и replay.

## Практические рекомендации

1. Определите domain events как бизнес-факты.
2. Сразу введите versioning policy событий.
3. Добавьте snapshotting для длинных event streams.
4. Мониторьте projection lag и dead-letter.
## Стандарты и источники

- Fowler, [CQRS](../../glossary.md#abbr-020)/Event Sourcing articles.
- Greg Young talks/papers on Event Sourcing.
- Vaughn Vernon, [DDD](../../glossary.md#abbr-024) and event patterns.
