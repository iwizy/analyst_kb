# ACMM

ACMM (Architecture Capability Maturity Model) оценивает зрелость архитектурной функции: от разрозненных практик к системному управлению архитектурой предприятия.

## Уровни сложности

### Базовый уровень

- понимать роль архитектурной функции в организации;
- оценивать базовые capability EA-команды;
- фиксировать минимальные архитектурные артефакты.

### Средний уровень

- выстраивать архитектурный governance-процесс;
- связывать архитектурные решения с roadmap и бюджетами;
- внедрять архитектурные ревью и стандарты.

### Продвинутый уровень

- управлять архитектурой на уровне portfolio;
- применять capability-based planning;
- измерять влияние архитектуры на бизнес-результаты.

## Типовые области оценки

| Область | Что проверяется |
| --- | --- |
| Governance | роли, комитеты, правила принятия решений |
| Method | стандарт моделирования и lifecycle артефактов |
| Repository | наличие и актуальность архитектурного репозитория |
| Skills | компетенции архитекторов и аналитиков |
| Integration | связь EA с delivery и финансами |

## Уровни зрелости (упрощенно)

| Уровень | Характеристика |
| --- | --- |
| 1 Initial | архитектура ведется фрагментарно |
| 2 Under Development | есть отдельные практики и документы |
| 3 Defined | процессы архитектуры стандартизованы |
| 4 Managed | архитектура измеряется и управляется |
| 5 Optimized | архитектура постоянно улучшает бизнес-результат |

```kroki-plantuml
@startuml
left to right direction
rectangle "Architecture Principles" as P
rectangle "Architecture Repository" as R
rectangle "Architecture Review Board" as B
rectangle "Delivery Alignment" as D
rectangle "Business Outcomes" as O
P --> R
R --> B
B --> D
D --> O
@enduml
```

## Пример оценки

Контекст: крупный ритейл, уровень 2.

- есть отдельные C4/Archimate схемы, но нет единого репозитория;
- решения принимаются ситуативно;
- цель: уровень 3, внедрение EA governance board и architecture principles.

## Плюсы и минусы

| Плюсы | Минусы |
| --- | --- |
| дает измеримый путь развития EA | нужны зрелые governance-процессы |
| снижает архитектурный хаос | эффект проявляется постепенно |
| улучшает согласованность решений | требует поддержки руководства |

## Как внедрять ACMM

1. Определите scope оценки (домены/программы).
2. Проведите baseline assessment по областям capability.
3. Сформируйте gap list и приоритеты.
4. Запустите инициативы (governance, repository, standards).
5. Выполняйте регулярный reassessment.

## Типичные ошибки и как избежать

| Ошибка | Как избежать |
| --- | --- |
| оценка без бизнес-цели | связывайте maturity с OKR и рисками |
| нет архитектурного комитета | закрепляйте governance структуру |
| repo существует, но не актуален | назначайте владельцев и SLA обновления |
| нет связи с delivery | встраивайте EA checkpoints в SDLC |

## Инструменты и форматы

- Archi/BizzDesign, Confluence/Jira, architecture repository;
- артефакты: maturity report, architecture roadmap, principle catalog.
## Стандарты и источники

- TOGAF Standard: <https://www.opengroup.org/togaf>
- Enterprise Architecture maturity references (Open Group publications)
- Gartner/EA practice guidance
