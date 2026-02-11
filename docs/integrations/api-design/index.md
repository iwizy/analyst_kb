# Проектирование [API](../../glossary.md#abbr-005)

Подраздел описывает, как проектировать API-контракты с учетом совместимости, безопасности, эксплуатационных ограничений и жизненного цикла изменений.

## Уровни сложности

### Базовый уровень

- выбрать стиль API под бизнес-сценарий;
- описать минимальный контракт (ресурсы, операции, ошибки);
- закрепить правила именования и статусы ответов.

### Средний уровень

- внедрить contract-first, versioning и deprecation policy;
- настроить idempotency, rate limiting и authz;
- автоматизировать проверку контрактов в [CI](../../glossary.md#abbr-016).

### Продвинутый уровень

- управлять несколькими API-продуктами через gateway/portal;
- строить совместимость между командами и поколениями клиентов;
- внедрить governance: линтеры, каталоги, API scorecards.

## Принципы дизайна API

1. `Consumer-oriented design`: контракт должен отражать сценарий клиента, а не внутреннюю реализацию.
2. `Explicit semantics`: одинаковые операции и коды ошибок во всех сервисах.
3. `Compatibility first`: non-breaking изменения по умолчанию.
4. `Security by default`: authn/authz, [mTLS](../../glossary.md#abbr-052), audit и ограничение доступа на уровне контракта.
5. `Operability`: метрики, трассировка, correlation-id и поддержка graceful degradation.

## Выбор API-стиля

| Стиль | Когда применять | Сильные стороны | Ограничения |
| --- | --- | --- | --- |
| [REST](../../glossary.md#abbr-071) | публичные и BFF API | простота, [HTTP](../../glossary.md#abbr-038)-инфраструктура | over/under-fetching |
| GraphQL | сложные фронтенд-агрегации | гибкость выборки | сложность кеша и лимитов |
| [gRPC](../../glossary.md#abbr-036) | межсервисные вызовы с [SLA](../../glossary.md#abbr-079) по latency | бинарный протокол, строгость контрактов | сложнее для внешних клиентов |
| [SOAP](../../glossary.md#abbr-083) | enterprise/legacy и WS-* | строгие стандарты и безопасность | объем и сложность |
| JSON-RPC | command-oriented API | компактность, batch | слабее ресурсная модель |

## Жизненный цикл API

```kroki-plantuml
@startuml
start
:Определение потребителей и сценариев;
:Проектирование контракта;
:Линтинг и contract review;
:Реализация и contract testing;
:Публикация и onboarding клиентов;
:Мониторинг и анализ потребления;
:Изменения, deprecation, sunset;
stop
@enduml
```

## Минимальный набор governance-правил

- единая политика именования полей и URL;
- единая error model (problem details, error codes, trace id);
- обязательная секция `security` и `rate limits` в контракте;
- semver + changelog + migration notes;
- автоматическая проверка backward compatibility.

## Переход к подразделам

- [Сущности, атрибуты, контракты](entities-attributes-contracts.md)
- [Документирование API](api-documentation.md)
- [Версионирование API](versioning.md)
- [Обратная совместимость](backward-compatibility.md)
- [Безопасность API](security.md)
- [Лимиты и квоты](rate-limiting.md)
- [Идемпотентность](idempotency.md)
- [Обработка ошибок API](error-handling.md)
- [API Gateway и Service Mesh](api-gateway-and-service-mesh.md)
- [Форматы сериализации](serialization-formats/index.md)
## Стандарты и источники

- OpenAPI: <https://spec.openapis.org/oas/latest.html>
- GraphQL Spec: <https://spec.graphql.org/>
- [gRPC](../../glossary.md#abbr-036) docs: <https://grpc.io/docs/>
- JSON-RPC 2.0: <https://www.jsonrpc.org/specification>
- W3C [SOAP](../../glossary.md#abbr-083) 1.2: <https://www.w3.org/TR/soap12-part1/>
