# Master Data Management (MDM)

MDM это управление мастер-данными (клиенты, продукты, контрагенты, локации, сотрудники) для формирования единого доверенного представления сущностей в компании.

## Зачем нужен MDM

- устранить дубли и рассинхронизацию справочных данных;
- создать single source of truth для ключевых сущностей;
- повысить качество интеграций, аналитики и отчетности;
- снизить операционные и регуляторные риски.

## Типовые домены мастер-данных

- Customer
- Product
- Supplier/Partner
- Location
- Employee

## Архитектурные модели MDM

- Registry: хранится ссылка и "золотой" индекс, сами записи в источниках;
- Consolidation: сбор и очистка в центральном хранилище;
- Coexistence: bidirectional синхронизация между MDM и источниками;
- Centralized: master-запись живет в MDM как первичном контуре.

## Поток Golden Record

```kroki-plantuml
@startuml
left to right direction
rectangle "CRM" as CRM
rectangle "ERP" as ERP
rectangle "E-commerce" as ECOM
rectangle "MDM Hub\nMatching + Survivorship" as MDM
rectangle "Golden Record" as GOLD

CRM --> MDM
ERP --> MDM
ECOM --> MDM
MDM --> GOLD
GOLD --> CRM : Sync back
GOLD --> ERP : Sync back
GOLD --> ECOM : Sync back
@enduml
```

## Ключевые процессы

1. Profiling: оценка качества источников.
1. Standardization: нормализация форматов.
1. Matching: поиск дублей.
1. Survivorship: правило выбора "победивших" атрибутов.
1. Governance: владельцы, approval workflow, audit trail.

## Пример правил survivorship

- `phone`: брать самое свежее подтвержденное значение;
- `legal_name`: приоритет источника ERP;
- `email`: подтвержденный контакт из CRM.

## Пример результата

До MDM:

- один клиент в CRM, ERP и support-системе с разными ID и адресами.

После MDM:

- единый `customer_master_id`, согласованные атрибуты, прозрачная история изменений.

## Достоинства

- высокая консистентность критичных справочников;
- лучшее качество аналитики и сегментации;
- меньше интеграционных ошибок;
- ускорение процессов onboarding и обслуживания.

## Ограничения

- сложность внедрения и change management;
- необходимость участия бизнеса (не только IT);
- затраты на data quality и governance-процессы.

## Практические рекомендации

- начинать с 1-2 бизнес-критичных доменов;
- определить Data Owner и Data Steward до старта проекта;
- внедрять MDM вместе с Data Governance, а не отдельно;
- измерять эффект через KPI качества данных и time-to-resolution инцидентов.

## Смежные материалы

- [Data Governance](data-governance.md)
- [DWH и Data Lake](dwh-and-data-lake.md)
