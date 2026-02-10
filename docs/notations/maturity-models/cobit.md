# COBIT

COBIT — фреймворк управления и контроля ИТ, который помогает связать бизнес-цели, ИТ-процессы, риски и метрики.

## Уровни сложности

### Базовый уровень

- понимать домены и цели управления COBIT;
- проводить базовую capability assessment процесса;
- связывать контрольные цели с рисками.

### Средний уровень

- строить governance-модель и роли ответственности;
- использовать COBIT вместе с KPI/KRI;
- применять framework для аудита и соответствия.

### Продвинутый уровень

- интегрировать COBIT с enterprise risk management;
- выстраивать сквозной IT governance cycle;
- комбинировать COBIT с ITIL/ISO и внутренними стандартами.

## Домены COBIT

| Домен | Назначение |
| --- | --- |
| EDM | Evaluate, Direct and Monitor |
| APO | Align, Plan and Organize |
| BAI | Build, Acquire and Implement |
| DSS | Deliver, Service and Support |
| MEA | Monitor, Evaluate and Assess |

## Capability уровни (упрощенно)

| Уровень | Состояние процесса |
| --- | --- |
| 0 Incomplete | процесс не реализован |
| 1 Performed | процесс выполняется |
| 2 Managed | процесс планируется и контролируется |
| 3 Established | процесс стандартизован |
| 4 Predictable | процесс измеряется и предсказуем |
| 5 Optimizing | процесс непрерывно улучшается |

```kroki-plantuml
@startuml
left to right direction
rectangle "Assess\nтекущее состояние" as A
rectangle "Design\nконтроли и роли" as D
rectangle "Implement\nпроцессы и KPI/KRI" as I
rectangle "Monitor\nметрики и риски" as M
rectangle "Improve\nкорректирующие действия" as R
A --> D
D --> I
I --> M
M --> R
R --> A
@enduml
```

## Пример: DSS02 (управление инцидентами)

- текущий уровень: 2 (managed);
- целевой уровень: 3 (established);
- gap: нет единой taxonomy инцидентов и post-incident review;
- инициативы: стандарт классификации, runbooks, SLA-dashboard.

## Плюсы и минусы

| Плюсы | Минусы |
| --- | --- |
| сильная связь IT и бизнес-целей | высокий порог внедрения |
| полезен для аудита и регуляторики | может казаться избыточным для маленьких компаний |
| системно управляет рисками и контролями | требует зрелой governance культуры |

## Как внедрять

1. Выберите 1-2 приоритетных домена (например, DSS, MEA).
2. Проведите baseline capability assessment.
3. Определите target state и ключевые риски.
4. Запустите инициативы улучшения с владельцами.
5. Отслеживайте KPI/KRI и проводите reassessment.

## Типичные ошибки и как избежать

| Ошибка | Как избежать |
| --- | --- |
| "внедрить весь COBIT сразу" | начните с критичных процессов |
| нет измеримых KPI/KRI | фиксируйте метрики до запуска изменений |
| отсутствие ownership | назначайте process owner и control owner |
| формальное соблюдение без эффектов | проверяйте бизнес-результат изменений |

## Инструменты и форматы

- GRC-платформы, Confluence/Jira, BI dashboards;
- артефакты: control matrix, capability report, risk register.
## Стандарты и источники

- COBIT framework: <https://www.isaca.org/resources/cobit>
- ISACA governance resources: <https://www.isaca.org/>
- COSO/ERM related references
