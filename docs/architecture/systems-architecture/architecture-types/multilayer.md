# Многослойная арх
> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)

итектура

Layered architecture разделяет систему на слои с четкой ответственностью: presentation, application/business, persistence/integration.

## Уровни сложности

### Базовый уровень

- понимать назначение каждого слоя;
- соблюдать направление зависимостей;
- отделять бизнес-логику от инфраструктуры.

### Средний уровень

- применять Dependency Inversion и SOLID;
- строить testable use-case слой;
- управлять границами между слоями.

### Продвинутый уровень

- комбинировать layered с DDD/hexagonal;
- оптимизировать cross-layer performance bottleneck;
- предотвращать архитектурную эрозию.

## Типовая структура

```kroki-plantuml
@startuml
top to bottom direction
rectangle "Presentation Layer" as L1
rectangle "Application Layer" as L2
rectangle "Domain/Business Layer" as L3
rectangle "Persistence/Integration Layer" as L4
L1 --> L2
L2 --> L3
L2 --> L4
@enduml
```

## Преимущества

- высокая читаемость архитектуры;
- проще onboarding и тестирование;
- хорошая управляемость в enterprise-контуре.

## Недостатки

- риск layer-by-layer вызовов с ростом latency;
- избыточность для простых сервисов;
- опасность анемичной доменной модели.

## Когда выбирать

- корпоративные системы с формальными процессами;
- команды с разными ролями по слоям;
- требования к контролируемому развитию.

## Антипаттерны

- нарушение слоев (UI напрямую в DB);
- «толстый» application слой без доменных правил;
- слойность ради слойности без ценности.

## Практические рекомендации

1. Внешние зависимости не должны проникать в домен.
2. Применяйте interface-based ports на границах.
3. Покрывайте слой домена unit-тестами.
4. Контролируйте coupling между слоями метриками.
## Стандарты и источники

- Clean Architecture (R. Martin).
- Patterns of Enterprise Application Architecture (M. Fowler).
