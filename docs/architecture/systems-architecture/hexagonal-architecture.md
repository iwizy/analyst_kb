# Hexagonal Architecture

Hexagonal (Ports and Adapters) отделяет доменную логику от инфраструктуры. Домен не зависит от БД, HTTP, брокеров и других внешних технологий.

## Цель

- сделать бизнес-логику тестируемой и переносимой;
- снизить связность с фреймворками и инфраструктурой;
- упростить замену внешних адаптеров.

## Базовая модель

- `Domain Core`: правила предметной области.
- `Ports`: контракты входа/выхода.
- `Adapters`: реализация портов (REST, DB, MQ, UI).

```kroki-plantuml
@startuml
left to right direction
rectangle "Input Adapter\nREST Controller" as In
rectangle "Application Port" as PortIn
rectangle "Domain Core" as Domain
rectangle "Output Port" as PortOut
rectangle "Output Adapter\nPostgreSQL Repository" as Out

In --> PortIn
PortIn --> Domain
Domain --> PortOut
PortOut --> Out
@enduml
```

## Когда применять

- сложный домен и высокая цена регрессии;
- долгоживущие системы с эволюцией интеграций;
- потребность в высоком покрытии автотестами бизнес-правил.

## Типичные ошибки

- перенос всей логики в adapters;
- слишком много абстракций для простых CRUD-сервисов;
- неявные границы между application и domain слоями.
