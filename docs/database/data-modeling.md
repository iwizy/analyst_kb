# Проектирование модели данных
> Глоссарий терминов и сокращений: [Открыть](../glossary.md)



Модель данных связывает бизнес-процессы, требования и физическое хранение. Качественная модель снижает стоимость изменений и повышает прогнозируемость продукта.

## Уровни сложности

### Базовый

- различать концептуальную, логическую и физическую модель;
- выделять сущности, атрибуты, связи и ключи.

### Средний

- проектировать модель под query patterns и SLA;
- проводить ревью модели с бизнесом, разработкой и QA.

### Продвинутый

- управлять эволюцией схемы в distributed architecture;
- применять DDD (bounded context, aggregate boundaries).

## Этапы моделирования

| Этап | Цель | Артефакт |
| --- | --- | --- |
| Концептуальный | язык домена и границы | high-level ER, glossary |
| Логический | нормализованные сущности и связи | logical ER model |
| Физический | реализация в конкретной СУБД | DDL, индексы, partitioning |

## Сбор требований для модели

1. Определить доменные процессы и события.
2. Зафиксировать критичные запросы и отчеты.
3. Определить инварианты и целостность данных.
4. Уточнить SLA, growth и retention.
5. Проверить регуляторные ограничения.

## Пример: интернет-магазин (ER)

```kroki-plantuml
@startuml
entity Customer {
  *customer_id : bigint
  --
  email : text
}
entity Order {
  *order_id : bigint
  --
  customer_id : bigint
  status : text
  total_amount : numeric
}
entity OrderItem {
  *order_id : bigint
  *line_no : int
  --
  sku : text
  qty : int
  price : numeric
}

Customer ||--o{ Order
Order ||--o{ OrderItem
@enduml
```

## Кейсы по доменам

### CRM система

- сущности: `Client`, `Contact`, `Opportunity`, `Activity`;
- ключевые запросы: воронка, активность по сегментам, SLA обработки лидов.

### IoT платформа

- мастер-данные устройств в OLTP;
- телеметрия в TSDB/Wide-column;
- агрегаты и алерты в аналитическом контуре.

## Star vs Snowflake

| Критерий | Star | Snowflake |
| --- | --- | --- |
| Простота BI | выше | ниже |
| Нормализация измерений | низкая | выше |
| Производительность join | чаще лучше | зависит от движка |
| Сопровождение | проще для витрин | сложнее, но меньше дублирования |

## Изменения схемы и миграции

Рекомендации:

- backward-compatible first (additive changes);
- feature toggles для staged rollout;
- data backfill отдельными контролируемыми джобами;
- валидация качества данных после миграции.

## DDD и роль БД

- bounded context определяет границы схемы и ownership;
- aggregate root задает транзакционные границы;
- межконтекстные интеграции лучше делать через события/контракты, а не direct table access.

## Типовые ошибки

- проектирование только от сущностей, без запросов и SLA;
- смешение нескольких bounded contexts в одной "универсальной" таблице;
- отсутствие versioning для схемы и контрактов данных;
- игнорирование data quality контролей при миграциях.

## Практические рекомендации

1. Для каждого домена храните отдельный data dictionary.
2. Проводите архитектурное ревью модели перед релизом.
3. Фиксируйте ADR для ключевых решений по схеме.
4. Включайте тесты данных в CI/CD пайплайн.
## Стандарты и источники

- ISO/IEC 11179 (metadata registries): <https://www.iso.org/standard/35343.html>
- Martin Fowler, Data Mapper: <https://martinfowler.com/eaaCatalog/dataMapper.html>
- Eric Evans, Domain-Driven Design: <https://www.domainlanguage.com/ddd/>
- Kimball Group: <https://www.kimballgroup.com/>
