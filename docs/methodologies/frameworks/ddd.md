# DDD (Domain-Driven Design) как методологический подход

DDD помогает организовать разработку вокруг сложной предметной области, снижая доменные ошибки и улучшая управляемость требований.

## Уровни сложности

### Базовый уровень

- понимать bounded context, entity, value object, aggregate;
- использовать ubiquitous language;
- читать context map.

### Средний уровень

- структурировать backlog по bounded contexts;
- определять интеграции между контекстами;
- формировать доменные события и инварианты.

### Продвинутый уровень

- проектировать организацию команд по доменам;
- применять strategic design и context mapping patterns;
- сочетать DDD с Scrum/Kanban/SAFe.

## Ключевые принципы

- ubiquitous language;
- bounded contexts;
- explicit domain model;
- совместная работа бизнеса и инженерной команды.

## Процесс внедрения DDD

1. Domain discovery (workshops, event storming).
2. Выделение bounded contexts.
3. Проектирование агрегатов и правил инвариантов.
4. Формирование context map и integration contracts.
5. Регулярная ревизия доменной модели.

## Артефакты и роли

| Артефакт | Назначение |
| --- | --- |
| Ubiquitous Language Glossary | единый язык предметной области |
| Context Map | границы и связи контекстов |
| Aggregate Design Notes | правила консистентности |
| Domain Event Catalog | события и интеграционные триггеры |

Роли: domain expert, SA/BA, architect, product owner, engineering team.

## Шаблон Context Map (фрагмент)

| Context | Owner Team | Upstream/Downstream | Contract |
| --- | --- | --- | --- |
| Payments | Team A | Upstream для Billing | Event contract v2 |

## Плюсы и ограничения

Плюсы:

- уменьшает количество доменных ошибок;
- повышает качество требований;
- упрощает масштабирование по командам.

Ограничения:

- требует постоянной вовлеченности бизнеса;
- сложен при слабой архитектурной дисциплине;
- высокая стоимость начального внедрения.

## Пример проекта

Финтех-платформа: контексты `Onboarding`, `Payments`, `Ledger`, `Anti-Fraud`, `Reporting`.

## Связь с требованиями и рисками

- требования фиксируются в терминах bounded context;
- change impact оценивается через context map;
- ключевые риски: межконтекстная консистентность и контракты интеграций.

## Типичные ошибки

- смешение нескольких доменов в одном контексте;
- отсутствие explicit language;
- внедрение DDD только на уровне терминов без изменения структуры команд.## Источники

- Evans, *Domain-Driven Design*.
- Vernon, *Implementing Domain-Driven Design*.
- Fowler, context map patterns.
