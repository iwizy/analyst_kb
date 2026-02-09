# LeSS

LeSS (Large-Scale Scrum) - подход к масштабированию Scrum на несколько команд,
работающих над одним продуктом.

## Базовые принципы LeSS

- один продукт, один Product Backlog, один Product Owner;
- общая Definition of Done;
- синхронизированные спринты;
- кросс-функциональные feature teams.

## Организационная схема (упрощенно)

```kroki-plantuml
@startuml
left to right direction
actor "Product Owner" as PO
rectangle "Product Backlog" as PB
rectangle "Team A" as A
rectangle "Team B" as B
rectangle "Team C" as C
rectangle "Общий Sprint Review" as SR

PO --> PB
PB --> A
PB --> B
PB --> C
A --> SR
B --> SR
C --> SR
@enduml
```

## Когда LeSS подходит

- 2+ Scrum-команды работают над одним продуктом;
- нужна единая продуктовая приоритизация;
- критична согласованность инкремента между командами.

## Типичные риски

- фактическое разделение backlog по командам;
- функциональные, а не feature-команды;
- рост координационных издержек без явных интеграционных практик.

## Чек-лист качества

- Есть единый Product Backlog и единые правила приоритизации.
- Инкремент интегрируется в конце каждого спринта.
- Команды несут ответственность за value stream, а не за слой системы.
