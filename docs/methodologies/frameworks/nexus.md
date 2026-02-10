# Nexus

Nexus - расширение Scrum для 3-9 команд, работающих над одним продуктом. Основной акцент делается на управлении межкомандными зависимостями и интеграцией инкремента.

## Уровни сложности

### Базовый уровень

- понимать цель Nexus и отличие от классического Scrum;
- знать Nexus events и Nexus Integration Team;
- использовать Nexus Sprint Backlog.

### Средний уровень

- синхронизировать планирование и интеграцию между командами;
- управлять межкомандными зависимостями;
- внедрять общие quality standards.

### Продвинутый уровень

- масштабировать Nexus в распределенной среде;
- оптимизировать интеграционный контур и [CI/CD](../../glossary.md#abbr-017);
- сочетать Nexus с архитектурным governance.

## Основные элементы Nexus

- Nexus Integration Team;
- общий Product Backlog;
- Nexus Sprint Planning;
- Nexus Daily Scrum;
- Nexus Sprint Review;
- Nexus Sprint Retrospective.

## Схема Nexus-цикла

```kroki-plantuml
skinparam monochrome true
start
:Nexus Sprint Planning;
:Командные Sprint Planning;
:Nexus Daily Scrum;
:Командные Daily;
:Интеграция Increment;
:Nexus Sprint Review;
:Nexus Sprint Retrospective;
stop
```

## Артефакты и роли

| Артефакт | Назначение |
| --- | --- |
| Product Backlog | общий источник приоритетов |
| Nexus Sprint Backlog | видимость межкомандной работы |
| Integrated Increment | объединенный результат всех команд |

| Роль | Ответственность |
| --- | --- |
| Product Owner | приоритеты продукта |
| Nexus Integration Team | интеграция и разрешение зависимостей |
| Scrum Teams | реализация sprint backlog |

## Плюсы и ограничения

Плюсы:

- лучшее управление интеграцией в multi-team Scrum;
- прозрачность межкомандных зависимостей;
- единый релизный инкремент.

Ограничения:

- дополнительный coordination overhead;
- требуется зрелая инженерная практика интеграции;
- без сильного [CI/CD](../../glossary.md#abbr-017) эффективность падает.

## Пример проекта

Платформа подписок с 5 командами, где каждую итерацию требуется единый интегрированный релиз.

## Связь с требованиями и рисками

- backlog остается единым;
- риски фокусируются на dependency management и integration readiness;
- [AC](../../glossary.md#abbr-002)/[NFR](../../glossary.md#abbr-053) должны быть согласованы между командами заранее.

## Типичные ошибки

- недостаточное внимание к интеграции в течение спринта;
- отсутствие прозрачного dependency board;
- несогласованные [DoD](../../glossary.md#abbr-026) между командами.## Источники

- Nexus Guide: <https://www.scrum.org/resources/nexus-guide>
