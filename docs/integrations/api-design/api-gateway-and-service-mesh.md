# API Gateway и Service Mesh

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


API Gateway и Service Mesh решают разные задачи и чаще работают вместе: gateway на границе, mesh внутри сервисной сети.

## Уровни сложности

### Базовый уровень

- понимать границу ответственности gateway и mesh;
- использовать gateway для auth, routing, basic limits;
- использовать mesh для mTLS, retries, telemetry.

### Средний уровень

- проектировать edge + mesh архитектуру;
- централизовать политики безопасности и надежности;
- внедрять developer portal и onboarding.

### Продвинутый уровень

- выстраивать platform engineering вокруг API management;
- управлять multi-cluster и multi-region mesh;
- оптимизировать TCO self-hosted vs managed.

## Сравнение ролей

| Компонент | Основная роль | Типовые функции |
| --- | --- | --- |
| API Gateway | north-south traffic | authn/authz, routing, transform, quotas, monetization |
| Service Mesh | east-west traffic | mTLS, service identity, retries, circuit breaker, tracing |

## Схема развертывания

```kroki-plantuml
@startuml
left to right direction
actor Client
rectangle "API Gateway" as G
cloud "Kubernetes Cluster" {
  rectangle "Service A + sidecar" as A
  rectangle "Service B + sidecar" as B
  rectangle "Service C + sidecar" as C
  rectangle "Mesh Control Plane" as CP
}
Client --> G
G --> A
A --> B
B --> C
CP --> A
CP --> B
CP --> C
@enduml
```

## Сравнение инструментов API Gateway

| Инструмент | Сильные стороны | Ограничения |
| --- | --- | --- |
| Kong | богатый open-source ecosystem, плагины | enterprise-фичи платные |
| Apigee | зрелое API management и аналитика | высокий TCO |
| AWS API Gateway | managed в AWS, быстрая интеграция | vendor lock-in и ограничения по кастомизации |
| Azure API Management | сильный enterprise control plane | cost при большом трафике |
| NGINX | высокая производительность и гибкость | требует больше самостоятельной сборки платформы |

## Сравнение Service Mesh

| Mesh | Сильные стороны | Ограничения |
| --- | --- | --- |
| Istio | богатые policy и traffic management | высокая сложность эксплуатации |
| Linkerd | легковесность и простота | меньше продвинутых фич |
| Consul | сильная сервисная сетка + сервис-дискавери | отдельная операционная сложность |
| Kuma | мультиплатформенность и простые политики | экосистема меньше, чем у Istio |

## Примеры политик

### Circuit breaker (концептуально, mesh)

```yaml
policy: circuit-breaker
service: payments
maxConnections: 100
maxRequests: 200
consecutiveErrors: 5
```

### Gateway rate limit (концептуально)

```yaml
route: /public/*
limitPerMinute: 120
burst: 30
```

## Self-hosted vs managed

| Модель | Когда выбирать |
| --- | --- |
| Self-hosted | есть сильная platform-команда, нужен полный контроль |
| Managed | нужна скорость запуска и снижение ops-нагрузки |

## Типичные ошибки

- попытка решить все задачи только gateway или только mesh;
- дублирование политик и конфликты между слоями;
- отсутствие owner на API onboarding и lifecycle;
- недостаточная observability маршрутов и политик.
## Стандарты и источники

- Istio docs: <https://istio.io/latest/docs/>
- Linkerd docs: <https://linkerd.io/>
- Kong docs: <https://docs.konghq.com/>
- Envoy docs: <https://www.envoyproxy.io/docs/>
