# Модульный монолит

> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)


Модульный монолит сочетает единый процесс с жесткими внутренними границами домена. Это частая целевая точка перед микросервисной декомпозицией.

## Уровни сложности

### Базовый уровень

- понимать идею модулей и public API внутри монолита;
- разделять функциональность по бизнес-областям;
- избегать cross-module хаоса.

### Средний уровень

- внедрять модульные контракты и архитектурные проверки;
- вести независимый lifecycle модулей;
- готовить модули к внешнему извлечению.

### Продвинутый уровень

- использовать модульность как подготовку к микросервисам;
- управлять данными: schema-per-module, anti-corruption adapters;
- мигрировать incrementally через Strangler.

## Структура

```kroki-plantuml
@startuml
left to right direction
rectangle "Modular Monolith" as M {
  package "Orders Module" as O
  package "Payments Module" as P
  package "Catalog Module" as C
}
database "DB\n(schema per module)" as DB
O --> P : through module API
O --> C : read via API
O --> DB
P --> DB
C --> DB
@enduml
```

## Преимущества

- управляемые границы без distributed overhead;
- быстрый локальный dev loop;
- понятный путь к сервисной декомпозиции.

## Недостатки

- общий релизный контур;
- архитектурная дисциплина обязательна;
- риск «скрытых» зависимостей через shared util/data.

## Когда выбирать

- продукт растет, но microservices еще преждевременны;
- необходимо ускорить команды без резкого роста сложности;
- доменные границы уже просматриваются.

## Антипаттерны

- модули только в папках без контрактов;
- shared database без ownership;
- "god common" библиотека как канал связности.

## Практические рекомендации

1. Для каждого модуля: owner, API, данные, SLA.
2. Запрет прямых вызовов во внутренности соседнего модуля.
3. Введите dependency rules в CI.
4. Подготовьте module extraction backlog.
## Стандарты и источники

- DDD references on bounded contexts.
- Modular monolith engineering guides (industry practices).
