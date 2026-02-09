# TOGAF

TOGAF (The Open Group Architecture Framework) - один из наиболее используемых
фреймворков для развития архитектуры предприятия. Центральный механизм TOGAF -
цикл ADM (Architecture Development Method).

## Что дает TOGAF

- повторяемый процесс проектирования архитектуры;
- единый формат архитектурных артефактов;
- управляемый переход от текущего состояния к целевому.

## Фазы ADM (укрупненно)

- Preliminary и Vision: контекст, принципы и целевое видение.
- Business Architecture: бизнес-способности и процессы.
- Information Systems Architecture: данные и приложения.
- Technology Architecture: инфраструктурный слой.
- Opportunities and Solutions, Migration Planning: сценарии реализации и дорожная карта.
- Implementation Governance и Architecture Change Management: контроль внедрения и изменений.

## Пример применения на программе трансформации

```kroki-plantuml
@startuml
left to right direction
rectangle "Vision" as V
rectangle "Business" as B
rectangle "Data/Application" as A
rectangle "Technology" as T
rectangle "Migration Plan" as M
rectangle "Governance" as G

V --> B
B --> A
A --> T
T --> M
M --> G
G --> V : Change feedback
@enduml
```

## Типичные ошибки

- формальное внедрение TOGAF без связи с решениями на проектах;
- избыточная документация без практической ценности;
- отсутствие архитектурного governance после утверждения target state.

## Чек-лист качества

- Зафиксированы архитектурные принципы и критерии соответствия.
- Для перехода as-is -> to-be есть реалистичная roadmap.
- Контроль архитектурных отклонений встроен в delivery-процесс.

## Практическое дополнение

1. Перед применением подхода зафиксируйте измеримую цель (SLA, lead time, error rate, time-to-market).
1. На архитектурном review проверяйте соответствие решения ограничениям безопасности, интеграций и эксплуатации.
1. Добавляйте в backlog минимум одну задачу на снижение архитектурного риска для каждой high-impact зоны.
