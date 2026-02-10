# LeSS (Large-Scale Scrum)

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


LeSS масштабирует Scrum на несколько команд, сохраняя его базовые принципы: один продукт, один backlog, один Product Owner.

## Уровни сложности

### Базовый уровень

- понимать базовые правила LeSS;
- использовать единый Product Backlog;
- синхронизировать спринты команд.

### Средний уровень

- организовывать feature teams;
- управлять межкомандной интеграцией;
- настраивать общие review/retro события.

### Продвинутый уровень

- внедрять LeSS в крупных продуктовых организациях;
- минимизировать coordination overhead;
- выравнивать архитектуру и организационную структуру.

## Базовые принципы LeSS

- one product, one product backlog, one PO;
- общая Definition of Done;
- синхронные спринты;
- feature teams вместо компонентных команд.

## Организационная схема

```kroki-plantuml
skinparam monochrome true
left to right direction
actor PO as "Product Owner"
rectangle PB as "Product Backlog"
rectangle A as "Team A"
rectangle B as "Team B"
rectangle C as "Team C"
rectangle SR as "Joint Sprint Review"
PO --> PB
PB --> A
PB --> B
PB --> C
A --> SR
B --> SR
C --> SR
```

## Артефакты и роли

- Product Backlog (единый);
- Sprint Backlogs (на уровне команд);
- общий Increment;
- общая Definition of Done.

Роли: Product Owner, Scrum Masters, Teams.

## Плюсы и ограничения

Плюсы:

- единая продуктовая фокусировка;
- снижение локальной оптимизации;
- прозрачная интеграция результата.

Ограничения:

- высокие требования к организационной зрелости;
- сложность перехода от component teams к feature teams;
- возможен рост координационных издержек.

## Пример проекта

B2C-суперапп с 4 Scrum-командами, единым roadmap и общим релизным циклом.

## Связь с требованиями и рисками

- приоритизация требований централизована через единый backlog;
- ключевые риски: зависимость между командами и интеграционная готовность;
- NFR должны иметь общие для всех команд критерии DoD.

## Типичные ошибки

- фактическое разделение backlog по командам;
- разные DoD в одном продукте;
- отсутствие интеграции инкремента к концу спринта.## Источники

- LeSS official site: <https://less.works/>
