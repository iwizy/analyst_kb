# Базы данных
Раздел описывает практический подход к выбору, проектированию и эксплуатации баз данных для системного аналитика и архитектора.

## Уровни сложности

### Базовый уровень

- понять отличия реляционных, NoSQL, NewSQL и реестров;
- научиться выбирать БД по нагрузке, консистентности и [SLA](../glossary.md#abbr-079);
- освоить базовые подходы к схеме, индексам, репликации и backup.

### Средний уровень

- проектировать модель данных под домен и тип запросов;
- балансировать ACID/BASE/[CAP](../glossary.md#abbr-013)/[PACELC](../glossary.md#abbr-061) под бизнес-риски;
- строить комбинированные архитектуры (primary store + специализированные хранилища).

### Продвинутый уровень

- проектировать multi-region и масштабируемые кластеры;
- выстраивать [DWH](../glossary.md#abbr-029)/Lakehouse/[MDM](../glossary.md#abbr-049)/Data Governance на уровне платформы;
- управлять отказоустойчивостью, [CDC](../glossary.md#abbr-014), disaster recovery и стоимостью владения.

## Карта тем раздела

```kroki-plantuml
@startuml
left to right direction
rectangle "Выбор типа БД" as T
rectangle "Консистентность и распределение\nACID BASE CAP PACELC" as C
rectangle "Модель данных\nER DDD Нормализация" as M
rectangle "SQL и оптимизация\nиндексы планы блокировки" as Q
rectangle "Масштабирование\nпартиционирование шардирование" as S
rectangle "Платформа данных\nDWH Lakehouse MDM Governance" as P
rectangle "Эксплуатация\nрепликация backup DR" as O

T --> C
C --> M
M --> Q
Q --> S
S --> P
P --> O
@enduml
```

## Что анализировать при выборе СУБД

| Параметр | Что измерять | Почему важно |
| --- | --- | --- |
| Объем данных | текущий объем, годовой прирост, горячие данные | влияет на хранение, партиционирование и стоимость |
| [Нагрузка](../glossary.md#term-046) | [RPS](../glossary.md#abbr-075) read/write, peak multiplier | определяет архитектуру и тип индексов |
| Профиль запросов | read/write ratio, сложность join/aggregation | влияет на выбор [SQL](../glossary.md#abbr-084) vs NoSQL и доп. витрин |
| Требования к консистентности | strong, causal, eventual | определяет [CAP](../glossary.md#abbr-013)/[PACELC](../glossary.md#abbr-061) компромисс |
| [SLA](../glossary.md#abbr-079)/[SLO](../glossary.md#abbr-081) | latency p95, availability, [RTO](../glossary.md#abbr-076)/[RPO](../glossary.md#abbr-074) | влияет на топологию, репликацию, backup |
| Регуляторика | хранение ПДн, аудит, сроки retention | задает ограничения по платформе и процессам |

## Пример оценки нагрузки

| [Метрика](../glossary.md#term-044) | Значение (пример e-commerce) | Интерпретация |
| --- | --- | --- |
| Data size | 3.2 TB | нужен tiered storage и partition strategy |
| Growth | 180 GB/месяц | через 12 месяцев +2 TB, нужен capacity plan |
| Peak RPS | 4 500 read / 900 write | read-heavy, возможны read replicas + cache |
| Read/Write ratio | 5:1 | primary [OLTP](../glossary.md#abbr-060) + реплики/поиск |
| P95 latency target | <= 120 ms (каталог), <= 300 ms (чекаут) | разные SLA для read и tx сценариев |
| Availability | 99.95 | требует HA и отработанный failover runbook |

## Практический сценарий: PostgreSQL vs MongoDB

Контекст: интернет-магазин, нужны транзакционные заказы, гибкий каталог, поиск по атрибутам.

### Шаг 1. Критерии

| Критерий | Вес | PostgreSQL | MongoDB | Комментарий |
| --- | --- | --- | --- | --- |
| Транзакционная целостность заказа/оплаты | 5 | 5 | 3 | PostgreSQL проще для строгих инвариантов |
| Гибкость схемы каталога | 3 | 3 | 5 | документная модель удобнее для вариативных атрибутов |
| Сложные отчеты SQL | 4 | 5 | 3 | SQL и mature planner в PostgreSQL |
| Скорость эволюции модели | 3 | 3 | 5 | в Mongo проще менять структуру документов |
| Эксплуатация команды | 2 | 4 | 4 | зависит от компетенций и tooling |

### Шаг 2. Итоговое решение

- `PostgreSQL` как primary store для заказов, оплат, складских резервов.
- `MongoDB` или search-индекс как специализированный слой каталога.
- [CDC](../glossary.md#abbr-014) из PostgreSQL в аналитический контур.

### Упрощенный граф профиля нагрузки

| Система | Transaction integrity | Query flexibility | Schema agility |
| --- | --- | --- | --- |
| PostgreSQL | █████ | █████ | ███ |
| MongoDB | ███ | ████ | █████ |

## Комбинированные архитектуры

| [Паттерн](../glossary.md#term-052) | Когда применять | Пример |
| --- | --- | --- |
| Primary + Cache | высокий read RPS и hot keys | PostgreSQL + Redis |
| Primary + Search | полнотекст и фасетная фильтрация | PostgreSQL + OpenSearch |
| Primary + Event Store | доменные события и аудируемость | PostgreSQL + Kafka |
| Primary + Analytics | тяжелые отчеты отдельно от OLTP | PostgreSQL + ClickHouse/Redshift |

## Типовые ошибки

- выбор БД по популярности, а не по профилю данных и SLA;
- попытка закрыть все сценарии одной СУБД;
- отсутствие теста нагрузки до архитектурного решения;
- игнорирование RTO/RPO и процедур восстановления;
- проектирование индексов до понимания реальных query patterns.

## Практические рекомендации

1. Сначала фиксируйте доменные инварианты, затем выбирайте модель хранения.
2. Для критичных решений делайте [ADR](../glossary.md#abbr-003) с измеримыми критериями.
3. Валидируйте выбор через PoC: latency, throughput, отказ и восстановление.
4. Планируйте migration path и observability до запуска в production.
## Стандарты и первоисточники

- [ISO](../glossary.md#abbr-043)/IEC 9075 SQL: <https://www.iso.org/standard/76583.html>
- CAP theorem paper (Gilbert, Lynch): <https://dl.acm.org/doi/10.1145/564585.564601>
- PACELC (Abadi): <https://ieeexplore.ieee.org/document/6133253>
- Google Spanner paper: <https://research.google/pubs/pub39966/>
- Kimball & Ross, The Data Warehouse Toolkit: <https://www.wiley.com/en-us/The+Data+Warehouse+Toolkit%2C+3rd+Edition-p-9781118530801>
- PostgreSQL docs: <https://www.postgresql.org/docs/>
- MongoDB docs: <https://www.mongodb.com/docs/>
