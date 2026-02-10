# Арх
итектура информационных систем

Подраздел фокусируется на практических решениях: стиль архитектуры, паттерны взаимодействия, масштабирование, надежность и эксплуатационная модель.

## Уровни сложности

### Базовый уровень

- выбрать архитектурный стиль под контекст;
- понимать базовые паттерны взаимодействия;
- читать [C4](../../glossary.md#abbr-011)-диаграммы и базовые [UML](../../glossary.md#abbr-092)-схемы.

### Средний уровень

- проектировать сервисные границы и data ownership;
- выбирать sync/async, cache и resilience-паттерны;
- оформлять решения в [ADR](../../glossary.md#abbr-003) и review-процессе.

### Продвинутый уровень

- выстраивать целевую архитектуру на 2-3 года;
- проводить миграции без больших остановок;
- управлять зрелостью архитектуры на уровне организации.

## Навигация по темам

1. Архитектурные стили: от монолита до event-driven/serverless.
2. Принципы и паттерны: SOLID, GoF, [DDD](../../glossary.md#abbr-024), hexagonal, [CQRS](../../glossary.md#abbr-020)/ES.
3. Взаимодействие: sync/async, оркестрация/хореография, [API](../../glossary.md#abbr-005) gateway/mesh.
4. Эксплуатация: кэширование, масштабирование, надежность.
5. Документирование: C4, Archimate, UML, ADR.
6. Оценка: зрелость архитектуры и архитектурные ревью.

## Схема принятия архитектурного решения

```kroki-plantuml
@startuml
start
:Определить FR/NFR и ограничения;
:Выбрать архитектурный стиль;
:Сформировать паттерны взаимодействия;
:Проверить риски надежности и масштабирования;
:Зафиксировать ADR и диаграммы;
:Провести архитектурное ревью;
stop
@enduml
```

## Кросс-связи

- [Интеграции](../../integrations/index.md): паттерны обмена, идемпотентность, rate limits.
- [Базы данных](../../database/index.md): выбор хранилищ, шардирование, консистентность.
- [Требования](../../requirements/index.md): трассировка архитектурных решений к [NFR](../../glossary.md#abbr-053).
- [Нотации](../../notations/index.md): [C4](../../glossary.md#abbr-011), [UML](../../glossary.md#abbr-092), Archimate.

## Переход к подразделам

- [Виды архитектур](architecture-types/index.md)
- [Архитектурные паттерны и антипаттерны](patterns-antipatterns.md)
- [GoF-паттерны](gof-patterns.md)
- [Hexagonal Architecture](hexagonal-architecture.md)
- [Event Sourcing и CQRS](event-sourcing-cqrs.md)
- [Синхронное и асинхронное взаимодействие](sync-async.md)
- [Кэширование](caching.md)
- [Оркестрация и хореография](orchestration-choreography.md)
- [Масштабирование сервисов](service-scaling.md)
- [Отказоустойчивость](resilience.md)
- [API Gateway и Service Mesh](api-gateway-service-mesh.md)
- [Документирование и визуализация архитектуры](documentation-visualization.md)
- [Зрелость и архитектурные ревью](maturity-reviews.md)
- [Практические кейсы и миграции](practical-cases.md)
## Стандарты и источники

- [ISO](../../glossary.md#abbr-043)/IEC/[IEEE](../../glossary.md#abbr-041) 42010.
- TOGAF standard: <https://www.opengroup.org/togaf>
- C4 model: <https://c4model.com/>
