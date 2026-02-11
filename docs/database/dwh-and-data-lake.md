# [DWH](../glossary.md#abbr-029), Data Lake и Lakehouse

Современная платформа данных обычно сочетает несколько слоев: DWH для trusted-аналитики, Data Lake для сырья, Lakehouse для объединения гибкости и управляемости.

## Уровни сложности

### Базовый уровень

- различать DWH, Data Lake, Lakehouse;
- понимать [ETL](../glossary.md#abbr-033) vs [ELT](../glossary.md#abbr-030) и batch vs stream.

### Средний уровень

- проектировать слои staging/ODS/curated;
- выбирать инструменты оркестрации и трансформации.

### Продвинутый уровень

- внедрять Data Mesh и data contracts;
- оптимизировать стоимость владения и производительность платформы.

## ETL vs ELT

| Подход | Что происходит первым | Когда использовать |
| --- | --- | --- |
| ETL | трансформация до загрузки | жесткая схема и контроль качества до DWH |
| ELT | загрузка сырья, затем трансформация | cloud DWH/Lakehouse с масштабируемым compute |

## Batch vs Stream

| Подход | Плюсы | Ограничения |
| --- | --- | --- |
| Batch | простота, предсказуемость | выше задержка данных |
| Stream | near-real-time аналитика | выше сложность и требования к мониторингу |

## Инструменты

- dbt: трансформации и тесты модели;
- Airflow: оркестрация;
- Kafka/Flink/Spark: потоковые и batch pipelines.

## Архитектура слоев

```kroki-plantuml
@startuml
left to right direction
rectangle "Sources\nApps ERP CRM" as SRC
rectangle "Bronze\nraw" as B
rectangle "Silver\ncleaned" as S
rectangle "Gold\nbusiness marts" as G
rectangle "BI/ML" as BI

SRC --> B
B --> S
S --> G
G --> BI
@enduml
```

## Staging и ODS слой

| Слой | Назначение | Типовые правила |
| --- | --- | --- |
| Staging | техническая приемка сырых данных | минимальные преобразования, контроль формата |
| [ODS](../glossary.md#abbr-105) | оперативная консолидация по домену | дедупликация, базовые ключи, SLA на свежесть |
| Curated/Gold | бизнес-модели и витрины | стандартизованные метрики и data contracts |

Практика: бизнес-отчеты не строятся напрямую на raw/staging, чтобы не ломать единые определения KPI.

## Data Mesh и data contracts

- Data Mesh: data ownership в доменных командах, данные как продукт.
- Data Contracts: формальные контракты схемы, качества и [SLA](../glossary.md#abbr-079) между producer/consumer.

## Сравнение платформ

| Платформа | Сильные стороны | Ограничения |
| --- | --- | --- |
| Snowflake | разделение compute/storage, удобное масштабирование | стоимость при неуправляемом compute |
| Redshift | глубокая интеграция AWS | требует tuning для сложных нагрузок |
| ClickHouse | высокая скорость аналитики и агрегаций | требует архитектурной дисциплины по ingest/модели |

## Выбор платформы по стоимости владения (TCO)

| Критерий | Snowflake | Redshift | ClickHouse |
| --- | --- | --- | --- |
| Модель оплаты | compute + storage отдельно | кластерные ноды + storage | self-managed/managed, зависит от поставки |
| Порог входа | низкий для managed cloud | средний, нужен tuning кластера | выше для self-managed сценария |
| Эластичность | высокая | средняя | зависит от deployment-модели |
| Сценарий, где силен | быстрый запуск корпоративной аналитики | AWS-центричные платформы | high-throughput near-real-time аналитика |

## Кейсы по отраслям

- Финансы: [DWH](../glossary.md#abbr-029) для регуляторной отчетности + строгий lineage.
- E-commerce: Lakehouse для near-real-time маркетинговой аналитики.
- IoT: stream ingestion + TSDB/Lake для телеметрии и прогнозов.

## Типовые ошибки

- отсутствие единого словаря метрик между доменами;
- попытка строить [BI](../glossary.md#abbr-008) напрямую на raw-слое;
- нет data quality тестов в пайплайне;
- неуправляемый рост стоимости compute/storage.

## Практические рекомендации

1. Введите слой контрактов и тестов данных (dbt tests/data contracts).
2. Разделите SLA для batch и stream контуров.
3. Внедрите FinOps-практики для контроля стоимости.
4. Документируйте lineage и ownership каждого data продукта.
## Стандарты и источники

- Kimball Group: <https://www.kimballgroup.com/>
- dbt docs: <https://docs.getdbt.com/>
- Apache Airflow docs: <https://airflow.apache.org/docs/>
- Apache Flink docs: <https://nightlies.apache.org/flink/>
- Apache Spark docs: <https://spark.apache.org/docs/latest/>
- Data Mesh (Zhamak Dehghani): <https://martinfowler.com/articles/data-mesh-principles.html>
