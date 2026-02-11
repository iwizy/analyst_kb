# [DWH](../../glossary.md#abbr-029)

DWH (Data Warehouse) обеспечивает единую, согласованную и историчную основу для аналитики и управленческих решений.

## Уровни сложности

### Базовый уровень

- понимать различие [OLTP](../../glossary.md#abbr-060) и [OLAP](../../glossary.md#abbr-059);
- знать роли слоев `staging`, `core`, `data mart`;
- формулировать требования к витринам.

### Средний уровень

- работать с моделями `fact/dimension`;
- отличать `star` и `snowflake`;
- задавать [SLA](../../glossary.md#abbr-079) обновления и проверки качества.

### Продвинутый уровень

- участвовать в проектировании data products;
- задавать data contracts и lineage;
- управлять изменениями схем и impact analysis.

## Типовая архитектура DWH

```kroki-plantuml
left to right direction
rectangle "Источники\n(OLTP, CRM, Billing)" as S
rectangle "Staging" as ST
rectangle "Core/ODS" as ODS
rectangle "Data Mart" as DM
rectangle "BI/ML" as BI
S --> ST
ST --> ODS
ODS --> DM
DM --> BI
```

## Практический кейс: e-commerce

[Задача](../../glossary.md#term-028): единая отчетность по выручке и марже.

1. Источники: заказы, платежи, возвраты, логистика.
2. В `core` унифицируются статусы и справочники.
3. В витрине считаются [KPI](../../glossary.md#abbr-047): `GMV`, `net revenue`, `refund rate`.
4. [BI](../../glossary.md#abbr-008) показывает отклонения по каналам и регионам.

## Роль аналитика

- зафиксировать бизнес-термины и владельцев метрик;
- описать правила расчета и периодичность обновления;
- согласовать критерии качества данных;
- контролировать изменение логики при обновлениях источников.

## Типичные ошибки

- один и тот же KPI считается по-разному в разных витринах;
- нет владельца метрики и [SLA](../../glossary.md#abbr-079) загрузки;
- попытка сделать "универсальную витрину на все случаи".

## Кросс-ссылки

- [ETL/ELT](etl-elt.md)
- [DWH и Data Lake](../../database/dwh-and-data-lake.md)
- [Data Governance](../../database/data-governance.md)

## Источники

- The Data Warehouse Toolkit (Kimball & Ross).
- Building the Data Warehouse (Inmon).
- dbt docs: <https://docs.getdbt.com/>
