# Документирование и визуализация арх
> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)

итектуры

Архитектура должна быть не только правильно спроектирована, но и правильно зафиксирована: понятными диаграммами и решениями в ADR.

## Уровни сложности

### Базовый уровень

- использовать C4 для контекста и контейнеров;
- делать читаемые UML component/deployment диаграммы;
- фиксировать ключевые решения в ADR.

### Средний уровень

- связывать диаграммы с требованиями и NFR;
- поддерживать версии моделей;
- использовать Archimate для enterprise-view.

### Продвинутый уровень

- выстраивать единый архитектурный репозиторий;
- автоматизировать генерацию диаграмм (docs-as-code);
- встраивать review и approval workflow.

## C4 и когда какой уровень

| Уровень | Для чего | Аудитория |
| --- | --- | --- |
| C1 Context | границы системы и внешние акторы | бизнес, product, архитекторы |
| C2 Container | ключевые сервисы/приложения/БД | инженеры, архитекторы |
| C3 Component | внутренние компоненты контейнера | разработчики |
| C4 Code | детали реализации | команда разработки |

## Пример C4 (C1 + C2)

```kroki-plantuml
@startuml
left to right direction
actor User
rectangle "E-commerce Platform" as SYS
rectangle "Payment Provider" as PSP
User --> SYS
SYS --> PSP
@enduml
```

```kroki-plantuml
@startuml
left to right direction
node "Web App" as WEB
node "API Gateway" as GW
node "Order Service" as ORD
database "PostgreSQL" as DB
WEB --> GW
GW --> ORD
ORD --> DB
@enduml
```

## Archimate: когда применять

- для enterprise-ландшафта (бизнес + приложения + технологии);
- для дорожных карт трансформации;
- для связи capability и технологических инициатив.

Кросс-ссылка: [Нотации и моделирование](../../notations/index.md).

## UML component/deployment

### Component diagram (пример)

```kroki-plantuml
@startuml
package "Checkout" {
  [Checkout API]
  [Pricing Engine]
  [Payment Adapter]
}
[Checkout API] --> [Pricing Engine]
[Checkout API] --> [Payment Adapter]
@enduml
```

### Deployment diagram (пример)

```kroki-plantuml
@startuml
node "Kubernetes" {
  node "Order Pod" as OP
  node "Payment Pod" as PP
}
database "Managed DB" as MDB
OP --> MDB
PP --> MDB
@enduml
```

## ADR шаблон

```md
# ADR-00X: <Название решения>

## Контекст
- Текущее состояние
- Ограничения (NFR, регуляторика, сроки)

## Варианты
1. Вариант A
2. Вариант B
3. Вариант C

## Решение
- Выбранный вариант
- Почему выбран

## Последствия
- Плюсы
- Минусы/риски
- План пересмотра
```

## Практические рекомендации

1. Для каждой значимой архитектурной развилки — отдельный ADR.
2. Диаграммы и ADR храните рядом с кодом (Git).
3. Проставляйте ссылки на требования и NFR.
4. Обновляйте диаграммы при изменении релизного дизайна.

## Типичные ошибки

- диаграммы устаревают быстрее, чем код;
- ADR без альтернатив и trade-off;
- смешение уровней абстракции на одной схеме;
- отсутствие owner у архитектурной документации.
## Стандарты и источники

- C4 model: <https://c4model.com/>
- Archimate standard: <https://pubs.opengroup.org/architecture/archimate3-doc/>
- ISO/IEC/IEEE 42010.
- ADR guide: <https://adr.github.io/>
