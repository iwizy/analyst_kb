# Проектирование API

Проектирование API это проектирование контракта между командами и системами. Хороший API минимизирует стоимость изменений и снижает количество интеграционных инцидентов.

## Принципы

- Contract-first: сначала контракт, потом реализация.
- Явная семантика операций и ошибок.
- Консистентные naming conventions.
- Предсказуемая модель версионирования и депрекации.
- Безопасность и лимиты как часть контракта.

## Жизненный цикл API

1. Discovery: цели, потребители, SLA/SLO.
1. Design: ресурсы/операции, схемы, ошибки, политики.
1. Review: архитектурный и security review.
1. Publish: документация и SDK.
1. Operate: метрики, version lifecycle, incident response.

## Contract checklist

- endpoint/method/operation;
- request/response schema;
- error model;
- auth requirements;
- rate limits;
- idempotency policy;
- compatibility rules;
- observability fields (`trace_id`, `correlation_id`).

## Переход к подразделам

- [Сущности, атрибуты, контракты](entities-attributes-contracts.md)
- [Документирование API (OpenAPI, RAML)](api-documentation.md)
- [Версионирование API](versioning.md)
- [Обратная совместимость](backward-compatibility.md)
- [Безопасность API (OAuth 2.0, JWT, mTLS)](security.md)
- [Лимиты и квоты](rate-limiting.md)
- [Идемпотентность](idempotency.md)
- [API Gateway и Service Mesh](api-gateway-and-service-mesh.md)
- [Форматы сериализации](serialization-formats/index.md)
