# Практические кейсы и миграции

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Раздел показывает, как архитектурные стили работают в реальных сценариях и как выполнять миграции без "большого взрыва".

## Уровни сложности

### Базовый уровень

- понимать типовые эволюции архитектуры;
- видеть риски на каждом этапе миграции;
- выбирать incremental вместо big-bang.

### Средний уровень

- применять Strangler Fig;
- разделять данные и сервисы поэтапно;
- управлять consistency и latency рисками.

### Продвинутый уровень

- вести multi-wave migration с governance;
- управлять dual-write/read рисками;
- подтверждать эффект миграции метриками.

## Кейс 1: e-commerce monolith -> microservices

### Контекст

- монолит с ростом релизного цикла и конфликтами команд;
- цель: ускорить релизы и снизить blast radius.

### Шаги миграции (Strangler Fig)

1. Выделить bounded context `Catalog`.
2. Вынести read API через gateway routing.
3. Подключить CDC/events для синхронизации.
4. Перевести write-path и выключить legacy маршрут.

```kroki-plantuml
@startuml
left to right direction
rectangle "Legacy Monolith" as L
rectangle "New Catalog Service" as C
rectangle "API Gateway" as G
queue "CDC/Event Stream" as E
G --> L : old routes
G --> C : strangled routes
L --> E
E --> C
@enduml
```

## Кейс 2: fintech DDD architecture

- домены: onboarding, payments, ledger, compliance;
- паттерны: bounded contexts, CQRS для ledger-read, strict audit;
- риск: consistency между платежом и бухгалтерским учетом;
- решение: saga + idempotency + compensations.

## Кейс 3: high-throughput media event-driven platform

- ingest событий просмотров через bus;
- stream processing для real-time метрик;
- read models для аналитики и персонализации;
- ключевые риски: lag, schema drift, replay cost.

## Типовые проблемы и решения

| Проблема | Симптом | Подход |
| --- | --- | --- |
| Data consistency in microservices | рассинхрон статусов | saga/outbox + reconciliation jobs |
| Latency in distributed chain | p95 растет при пике | async декомпозиция + cache + timeout budgets |
| Monolith breakup risk | dual-write ошибки | incremental extraction + feature flags |

## Шаблон миграционного плана

| Этап | Цель | Метрика выхода |
| --- | --- | --- |
| Discovery | определить контексты и риски | context map + risk register |
| Pilot | вынести 1 bounded context | стабильный SLA пилота |
| Expansion | расширить extraction wave | снижение lead time |
| Stabilization | выключить legacy-пути | инциденты в пределах SLO |

## Практические рекомендации

1. Начинайте с наименее рискованных контекстов.
2. Не переносите одновременно code + data + org модель.
3. Используйте feature flags и canary release.
4. Для каждого этапа определяйте rollback plan.
## Стандарты и источники

- Strangler Fig pattern (Fowler): <https://martinfowler.com/bliki/StranglerFigApplication.html>
- Newman, *Monolith to Microservices*.
- DDIA migration and data consistency chapters.
