# Архитектура информационных систем

Подраздел описывает, как проектировать архитектуру под реальные бизнес-ограничения: скорость поставки, надежность, стоимость владения, требования к интеграциям.

## Основные темы

- архитектурные стили: монолит, модульный монолит, микросервисы, multilayer, SOA, микрофронтенды, P2P;
- синхронные и асинхронные взаимодействия;
- паттерны проектирования и архитектурные паттерны;
- DDD, hexagonal architecture, CQRS, event sourcing;
- масштабирование и отказоустойчивость;
- API gateway и service mesh.

## C4: контекст и контейнеры (пример e-commerce)

```kroki-plantuml
@startuml
left to right direction
actor "Покупатель" as Customer
rectangle "Платформа заказов" as Platform
rectangle "Платежный провайдер" as Payment
rectangle "Логистика" as Logistics
rectangle "CRM" as CRM

Customer --> Platform : оформляет заказ
Platform --> Payment : авторизация оплаты
Platform --> Logistics : создание доставки
Platform --> CRM : обновление профиля
@enduml
```

```kroki-plantuml
@startuml
left to right direction
node "Web/Mobile" as UI
node "API Gateway" as GW
node "Order Service" as Order
node "Catalog Service" as Catalog
node "Payment Service" as Pay
queue "Kafka" as Kafka
database "PostgreSQL" as DB

UI --> GW
GW --> Order
GW --> Catalog
GW --> Pay
Order --> DB
Order --> Kafka
Kafka --> Pay
@enduml
```

## Переход к подразделам

- [Виды архитектур](architecture-types/index.md)
- [Архитектурные паттерны и антипаттерны](patterns-antipatterns.md)
- [GoF-паттерны в системном проектировании](gof-patterns.md)
- [DDD и границы доменов](../design-approaches/oop-design/ddd.md)
- [Hexagonal Architecture](hexagonal-architecture.md)
- [Event Sourcing и CQRS](event-sourcing-cqrs.md)
- [Синхронное и асинхронное взаимодействие](sync-async.md)
- [Кэширование](caching.md)
- [Оркестрация и хореография](orchestration-choreography.md)
- [Масштабирование сервисов](service-scaling.md)
- [Отказоустойчивость](resilience.md)
- [API Gateway и Service Mesh](api-gateway-service-mesh.md)
- [Контейнеризация](containerization.md)
- [Мониторинг и поддержка](monitoring-support.md)
- [Облачные вычисления](cloud-computing.md)
