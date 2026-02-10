# DDD

> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)


Domain-Driven Design (DDD) строит архитектуру вокруг предметной области и языка бизнеса, а не вокруг технологий.

## Уровни сложности

### Базовый уровень

- использовать ubiquitous language;
- выделять bounded contexts;
- различать entity и value object.

### Средний уровень

- проектировать aggregates и инварианты;
- использовать repository и domain service;
- описывать context map между доменами.

### Продвинутый уровень

- согласовывать границы контекстов с оргструктурой;
- использовать anti-corruption layer для legacy;
- выстраивать governance domain model evolution.

## Ключевые концепции

| Концепция | Смысл |
| --- | --- |
| Ubiquitous Language | единый язык бизнеса и разработки |
| Bounded Context | граница, где термин имеет однозначный смысл |
| Entity | объект с идентичностью |
| Value Object | неизменяемое значение без идентичности |
| Aggregate | транзакционная граница целостности |
| Repository | абстракция доступа к aggregate |
| Domain Service | доменная операция вне конкретной entity |
| Context Map | карта отношений контекстов |

## Пример контекстов

```kroki-plantuml
@startuml
left to right direction
package "Sales" {
  [Order Aggregate]
}
package "Payments" {
  [Payment Aggregate]
}
package "Logistics" {
  [Shipment Aggregate]
}
[Order Aggregate] --> [Payment Aggregate] : PaymentRequested
[Order Aggregate] --> [Shipment Aggregate] : ShipmentRequested
@enduml
```

## Пример кода (агрегат + value object)

```java
class Money {
  private final BigDecimal amount;
  private final String currency;
}

class OrderAggregate {
  private OrderId id;
  private OrderStatus status;
  void confirmPayment(Money paid) { /* инварианты */ }
}
```

## Типичные ошибки

- один "глобальный" домен без bounded contexts;
- путаница domain event и integration event;
- repository как generic CRUD без бизнес-смысла.

## Практические рекомендации

1. Начните с event storming ключевого процесса.
2. Определите context ownership и interfaces.
3. Зафиксируйте инварианты aggregate.
4. Синхронизируйте DDD с [архитектурными стилями](../../systems-architecture/architecture-types/index.md).
## Стандарты и источники

- Evans, *Domain-Driven Design*.
- Vernon, *Implementing DDD*.
- DDD reference: <https://domainlanguage.com/ddd/reference/>
