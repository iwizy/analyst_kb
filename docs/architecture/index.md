# Проектирование и арх
итектура

Раздел описывает, как принимать архитектурные решения от уровня требований до эксплуатации: выбирать стиль системы, управлять компромиссами и документировать решения.

## Уровни сложности

### Базовый уровень

- понимать роль архитектуры в жизненном цикле продукта;
- различать ключевые архитектурные стили;
- связывать архитектурные решения с требованиями.

### Средний уровень

- выбирать стиль под [NFR](../glossary.md#abbr-053) и контекст команды;
- проектировать взаимодействие сервисов, кэширование и надежность;
- обосновывать решения через [ADR](../glossary.md#abbr-003) и диаграммы [C4](../glossary.md#abbr-011)/[UML](../glossary.md#abbr-092).

### Продвинутый уровень

- управлять архитектурной эволюцией и миграциями;
- выстраивать архитектурный governance и review-процессы;
- балансировать скорость delivery, стоимость и технический риск.

## Что такое архитектура ПО

Архитектура ПО — это совокупность ключевых структур системы, их отношений, ограничений и решений, которые определяют:

- как система достигает бизнес-целей;
- как она масштабируется и восстанавливается при сбоях;
- насколько просто ее менять и сопровождать.

## Архитектурные характеристики

| Характеристика | Что означает | Влияние на решения |
| --- | --- | --- |
| Availability | доступность сервиса | redundancy, failover, health checks |
| Scalability | рост без деградации [SLA](../glossary.md#abbr-079) | stateless design, sharding, autoscaling |
| Modifiability | скорость и безопасность изменений | модульность, слабая связность, контракты |
| Performance | время отклика и throughput | кэш, индексы, асинхронные потоки |
| Security | защита данных и каналов | [mTLS](../glossary.md#abbr-052), authz, шифрование, аудит |
| Testability | проверяемость поведения | чистые границы, dependency inversion, test seams |

## Роль системного аналитика в архитектуре

1. Переводит требования в архитектурные драйверы.
2. Выявляет компромиссы между NFR (например, consistency vs latency).
3. Уточняет границы доменов и интеграционные контракты.
4. Участвует в архитектурных ревью и фиксирует решения.

## Связь архитектуры с требованиями

- Функциональные требования определяют сценарии и границы ответственности.
- Нефункциональные требования задают ограничения по latency, надежности, безопасности и масштабу.
- Архитектурные решения должны иметь трассировку к этим требованиям.

Кросс-ссылки:

- [Требования](../requirements/index.md)
- [Интеграции](../integrations/index.md)
- [Базы данных](../database/index.md)
- [Нотации и моделирование](../notations/index.md)

## Карта архитектурного решения

```kroki-plantuml
@startuml
left to right direction
rectangle "Business Goals" as G
rectangle "Requirements\nFR/NFR" as R
rectangle "Architecture Drivers" as D
rectangle "Style + Patterns" as S
rectangle "Operational Model" as O
rectangle "ADR + Diagrams" as A
G --> R
R --> D
D --> S
S --> O
S --> A
@enduml
```

## Переход к разделам

- [Архитектура информационных систем](systems-architecture/index.md)
- [Подходы к проектированию](design-approaches/index.md)
- [Декомпозиция задач](task-decomposition.md)
- [Архитектура предприятия](enterprise-architecture/index.md)
## Стандарты и источники

- [ISO](../glossary.md#abbr-043)/IEC/[IEEE](../glossary.md#abbr-041) 42010: <https://www.iso.org/standard/50508.html>
- Software Architecture in Practice (Bass, Clements, Kazman)
- Martin Fowler architecture articles: <https://martinfowler.com/architecture/>
- O'Reilly Software Architecture patterns resources
