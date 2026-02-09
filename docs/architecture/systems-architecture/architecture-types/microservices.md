# Микросервисная архитектура

Микросервисный стиль делит систему на автономные сервисы с независимой поставкой и масштабированием. Он дает гибкость, но требует зрелого engineering и operations.

## Когда выбирать

- несколько команд с независимыми доменами;
- разные части продукта имеют разный профиль нагрузки;
- есть зрелые CI/CD, observability и практика инцидент-менеджмента.

## Плюсы

- независимые релизы сервисов;
- изоляция отказов;
- независимое масштабирование по доменам.

## Минусы

- distributed complexity: сеть, ретраи, таймауты, консистентность;
- сложнее тестирование end-to-end;
- рост стоимости эксплуатации и платформенной команды.

## Пример (C4 Container)

```kroki-plantuml
@startuml
left to right direction
node "API Gateway" as GW
node "Order Service" as Order
node "Inventory Service" as Inv
node "Payment Service" as Pay
queue "Kafka" as Kafka
database "Order DB" as ODB
database "Inventory DB" as IDB

GW --> Order
GW --> Inv
GW --> Pay
Order --> ODB
Inv --> IDB
Order --> Kafka : OrderCreated
Kafka --> Inv : reserve stock
Kafka --> Pay : request payment
@enduml
```

## Типичные ошибки

- distributed monolith из-за синхронных цепочек между всеми сервисами;
- shared database для «быстрой» интеграции;
- отсутствие контрактного тестирования и versioning policy.

## Чек-лист

- границы сервисов соответствуют bounded context;
- для каждого вызова заданы timeout/retry/idempotency;
- сквозные метрики и трассировка работают end-to-end.
