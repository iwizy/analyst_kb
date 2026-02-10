# Масштабирование сервисов

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Масштабирование — способность системы держать рост нагрузки с сохранением SLA и контролируемой стоимости.

## Уровни сложности

### Базовый уровень

- понимать vertical/horizontal scaling;
- различать stateless и stateful сервисы;
- использовать базовые load balancer паттерны.

### Средний уровень

- выбирать sharding/partitioning стратегии;
- учитывать CPU-bound vs IO-bound профиль;
- проектировать autoscaling по метрикам.

### Продвинутый уровень

- управлять multi-region scaling;
- работать с hot partitions и skew;
- оптимизировать cost/performance на платформе.

## Подходы масштабирования

| Тип | Суть | Когда применять |
| --- | --- | --- |
| Vertical | усиливаем один узел | short-term, stateful workloads |
| Horizontal | добавляем инстансы | stateless API, web workloads |
| Functional | делим по доменам | рост продукта и команд |

## Stateful vs Stateless

| Модель | Плюсы | Минусы |
| --- | --- | --- |
| Stateless | легко масштабировать за LB | вынос состояния во внешние хранилища |
| Stateful | проще локальная логика | сложнее failover и балансировка |

## Load Balancer

| Уровень | Пример | Когда |
| --- | --- | --- |
| L4 | NLB, TCP balancer | простая маршрутизация и throughput |
| L7 | Envoy, NGINX, HAProxy | smart routing, auth, retries |

## Sharding стратегии

| Стратегия | Плюсы | Риски |
| --- | --- | --- |
| Range | локальность данных | hot ranges |
| Hash | равномернее распределение | сложнее range-запросы |
| Consistent hashing | мягкий rebalancing | сложнее ключевой дизайн |

## Схема: stateless API за балансировщиком

```kroki-plantuml
@startuml
actor Client
rectangle "L7 Load Balancer" as LB
node "API-1" as A1
node "API-2" as A2
node "API-3" as A3
database "Shared DB/Cache" as DB
Client --> LB
LB --> A1
LB --> A2
LB --> A3
A1 --> DB
A2 --> DB
A3 --> DB
@enduml
```

## Autoscaling рекомендации

- Метрики: CPU, request rate, queue lag, p95 latency.
- Используйте cooldown и stabilization windows.
- Тестируйте scaling policies на synthetic peaks.

## Типичные ошибки

- скейлить сервис до устранения N+1/алгоритмических проблем;
- игнорировать stateful ограничения;
- не учитывать skew и hot keys в шардировании.

Кросс-ссылка: [Масштабирование БД](../../database/scaling/index.md).
## Стандарты и источники

- Kubernetes autoscaling docs.
- Google SRE: capacity planning.
- DDIA chapters on partitioning and replication.
