# Общая БД

Shared Database может быть оправдан в отдельных сценариях, но повышает связность между командами и усложняет независимые релизы.

## Уровни сложности

### Базовый уровень

- понимать модели shared schema и schema-per-service;
- знать риски сильной связности;
- применять минимальные ограничения доступа.

### Средний уровень

- разделять ownership таблиц и контрактов данных;
- внедрять CDC для публикации событий;
- управлять миграциями без простоя.

### Продвинутый уровень

- выделять bounded contexts из общей БД;
- использовать strangler pattern и dual-write migration;
- контролировать транзакционность и интеграционные риски при декомпозиции.

## Модели shared DB

| Модель | Плюсы | Риски |
| --- | --- | --- |
| Shared schema | простота старта | максимальная связность |
| Schema per service | лучше изоляция | остаются риски общей инфраструктуры |
| Database per service | независимость релизов | сложнее cross-service транзакции |

## DDD-паттерны

- `Shared Kernel`: ограниченный общий слой, согласованный несколькими командами;
- `Customer/Supplier`: один контекст поставляет данные другому по контракту;
- предпочтительно двигаться от shared schema к explicit contracts.

## Когда shared DB оправдана

- строгая консистентность в одном домене;
- очень низкая latency и tight coupling допустимы;
- единый lifecycle команд и релизов.

## Когда лучше избегать

- независимые release cycles сервисов;
- высокий масштаб и частые schema changes;
- multi-tenant или регуляторные требования к изоляции.

## Паттерн миграции монолита

```kroki-plantuml
@startuml
rectangle Monolith
database "Shared DB" as DB
rectangle "New Service A" as SA
queue "CDC Stream" as CDC

Monolith --> DB
DB --> CDC
CDC --> SA
note right of SA
Strangler pattern:
сначала read-model,
потом write ownership
end note
@enduml
```

## Управление конкуренцией

- ownership таблиц и колонок фиксируется явно;
- cross-service write запрещается по умолчанию;
- чтение через view/contracts, а не произвольные join;
- изменения схемы проходят через совместный review.

## Типичные ошибки

- прямые join между доменами без контрактов;
- скрытые зависимости в SQL-скриптах;
- отсутствие плана по декомпозиции shared schema;
- отсутствие CDC и событийной синхронизации.

## Контрольные вопросы

1. Почему shared DB выбрана вместо database-per-service?
2. Где границы ownership таблиц и прав записи?
3. Как выполняется миграция при выделении сервиса?
4. Какие риски консистентности при частичном переносе логики?

## Чек-лист самопроверки

- зафиксирована модель shared DB и ее ограничения;
- ownership данных и SQL-контрактов определен;
- внедрен CDC для асинхронной интеграции;
- есть дорожная карта декомпозиции;
- контролируются cross-service dependencies.

## Стандарты и источники

- Microservices data patterns: <https://microservices.io/patterns/data/>
- Debezium docs: <https://debezium.io/documentation/>
- DDD Reference: <https://www.domainlanguage.com/ddd/reference/>
