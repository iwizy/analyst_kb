# DWH, Data Lake и Lakehouse

Современная платформа данных обычно сочетает несколько слоев: DWH для trusted-аналитики, Data Lake для сырья, Lakehouse для объединения гибкости и управляемости.

## Уровни сложности

### Базовый

- различать DWH, Data Lake, Lakehouse;
- понимать ETL vs ELT и batch vs stream.

### Средний

- проектировать слои staging/ODS/curated;
- выбирать инструменты оркестрации и трансформации.

### Продвинутый

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

## Data Mesh и data contracts

- Data Mesh: data ownership в доменных командах, данные как продукт.
- Data Contracts: формальные контракты схемы, качества и SLA между producer/consumer.

## Сравнение платформ

| Платформа | Сильные стороны | Ограничения |
| --- | --- | --- |
| Snowflake | разделение compute/storage, удобное масштабирование | стоимость при неуправляемом compute |
| Redshift | глубокая интеграция AWS | требует tuning для сложных нагрузок |
| ClickHouse | высокая скорость аналитики и агрегаций | требует архитектурной дисциплины по ingest/модели |

## Кейсы по отраслям

- Финансы: DWH для регуляторной отчетности + строгий lineage.
- E-commerce: Lakehouse для near-real-time маркетинговой аналитики.
- IoT: stream ingestion + TSDB/Lake для телеметрии и прогнозов.

## Типовые ошибки

- отсутствие единого словаря метрик между доменами;
- попытка строить BI напрямую на raw-слое;
- нет data quality тестов в пайплайне;
- неуправляемый рост стоимости compute/storage.

## Практические рекомендации

1. Введите слой контрактов и тестов данных (dbt tests/data contracts).
2. Разделите SLA для batch и stream контуров.
3. Внедрите FinOps-практики для контроля стоимости.
4. Документируйте lineage и ownership каждого data продукта.

## Контрольные вопросы

1. Какие данные должны быть в Bronze/Silver/Gold?
2. Где требуется stream, а где достаточно batch?
3. Какой контракт качества данных обязателен для витрины?
4. Как контролируется стоимость платформы по доменам?

## Чек-лист самопроверки

- определена целевая архитектура DWH/Lake/Lakehouse;
- выбраны ETL/ELT и batch/stream стратегии;
- data contracts и quality tests внедрены;
- lineage и ownership зафиксированы;
- мониторится стоимость владения.

## Стандарты и источники

- Kimball Group: <https://www.kimballgroup.com/>
- dbt docs: <https://docs.getdbt.com/>
- Apache Airflow docs: <https://airflow.apache.org/docs/>
- Apache Flink docs: <https://nightlies.apache.org/flink/>
- Apache Spark docs: <https://spark.apache.org/docs/latest/>
- Data Mesh (Zhamak Dehghani): <https://martinfowler.com/articles/data-mesh-principles.html>
