# API Gateway и Service Mesh

Gateway и Service Mesh решают разные слои задач: gateway для north-south трафика, mesh для east-west трафика между сервисами.

## Уровни сложности

### Базовый уровень

- разделять ответственность gateway и mesh;
- применять routing, auth и rate limiting на входе;
- применять mTLS и retries внутри сервисной сети.

### Средний уровень

- проектировать edge + mesh architecture;
- внедрять единые политики безопасности;
- выбирать managed vs self-hosted решения.

### Продвинутый уровень

- управлять multi-cluster/multi-region сеткой;
- строить policy-as-code governance;
- оптимизировать TCO API platform.

## Роли компонентов

| Компонент | Назначение |
| --- | --- |
| API Gateway | authn/authz, routing, quotas, transformations |
| Service Mesh | mTLS, traffic policy, retry/circuit, telemetry |

## Схема

```kroki-plantuml
@startuml
actor Client
rectangle "API Gateway" as GW
cloud "K8s Cluster" {
  rectangle "Service A + Sidecar" as A
  rectangle "Service B + Sidecar" as B
  rectangle "Mesh Control Plane" as CP
}
Client --> GW
GW --> A
A --> B
CP --> A
CP --> B
@enduml
```

## Когда нужен gateway/mesh по стилям

| Стиль | Gateway | Mesh |
| --- | --- | --- |
| Монолит | часто достаточно reverse proxy | обычно не нужен |
| Микросервисы | почти обязателен | сильно рекомендуется |
| SOA | gateway + policy engine | опционально |
| Event-driven | gateway для API входа | mesh для сервисных вызовов |

## Примеры политик

- mTLS между сервисами;
- circuit breaker на внешние зависимости;
- retry with backoff для transient ошибок;
- rate limiting per client/route.

## Инструментальные trade-off

| Выбор | Сильные стороны | Ограничения |
| --- | --- | --- |
| Istio | богатые policy/traffic features | более высокая сложность |
| Linkerd | проще эксплуатация | меньше advanced-функций |
| Kong | мощный API gateway ecosystem | enterprise-фичи могут быть платными |
| NGINX | гибкость и скорость | больше ручного управления |

## Типичные ошибки

- дублирование политик в gateway и приложении;
- включение mesh без платформенной поддержки;
- отсутствие ownership политики маршрутов и безопасности.

Кросс-ссылки:

- [Интеграции: API Gateway и Service Mesh](../../integrations/api-design/api-gateway-and-service-mesh.md)
- [Безопасность API](../../integrations/api-design/security.md)

## Контрольные вопросы

1. Где должна жить конкретная политика: gateway, mesh или приложение?
2. Какие сервисы требуют mTLS и mutual auth в первую очередь?
3. Как контролируются изменения traffic policy?
4. Какой TCO у выбранной gateway/mesh платформы?

## Чек-лист самопроверки

- роли gateway и mesh разделены;
- политики безопасности и надежности задокументированы;
- есть observability north-south и east-west;
- есть процесс rollout/rollback политик;
- ownership платформы определен.

## Стандарты и источники

- Envoy docs: <https://www.envoyproxy.io/docs/>
- Istio docs: <https://istio.io/latest/docs/>
- Linkerd docs: <https://linkerd.io/>
