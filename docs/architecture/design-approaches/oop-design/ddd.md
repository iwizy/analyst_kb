# DDD

Domain-Driven Design (DDD) - подход, в котором архитектура строится вокруг предметной области, а не вокруг технологий.

## Когда применять

- сложные бизнес-правила и высокий риск доменных ошибок;
- несколько команд в одном продукте с разными зонами ответственности;
- частые изменения бизнес-логики.

## Ключевые концепции

| Концепция | Смысл |
| --- | --- |
| Ubiquitous Language | единый язык бизнеса и команды разработки |
| Bounded Context | граница модели и терминов |
| Entity / Value Object | объекты с идентичностью и объекты-значения |
| Aggregate | транзакционная граница целостности |
| Domain Event | событие предметной области |
| Context Map | карта взаимодействий контекстов |

## Пример контекстов

```kroki-plantuml
@startuml
left to right direction
package "Sales Context" {
  [Order Aggregate]
  [Pricing Service]
}
package "Payments Context" {
  [Payment Aggregate]
}
package "Logistics Context" {
  [Shipment Aggregate]
}

[Order Aggregate] --> [Payment Aggregate] : PaymentRequested
[Order Aggregate] --> [Shipment Aggregate] : ShipmentRequested
@enduml
```

## Пошаговое внедрение

1. Провести event storming по ключевому процессу.
1. Зафиксировать bounded contexts и владельцев.
1. Определить агрегаты и инварианты.
1. Выделить контракты интеграции между контекстами.
1. Отразить границы в коде, API и структуре команд.

## Типичные ошибки

- единая «глобальная» модель на все домены;
- путаница domain events и integration events;
- отсутствие связи между DDD-моделью и организационной структурой.

## Практический результат

DDD снижает когнитивную сложность, уменьшает конфликт терминов и ускоряет эволюцию продукта в больших командах.
