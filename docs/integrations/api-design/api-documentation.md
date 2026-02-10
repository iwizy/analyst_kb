# Документирование [API](../../glossary.md#abbr-005)

Качественная документация API должна быть одновременно читаемой для людей и валидируемой автоматически в [CI/CD](../../glossary.md#abbr-017).

## Уровни сложности

### Базовый уровень

- публиковать машиночитаемую спецификацию;
- описывать схемы запросов/ответов и ошибки;
- добавлять примеры и базовые сценарии.

### Средний уровень

- внедрить единый шаблон документации и style guide;
- использовать mock-серверы и contract testing;
- автоматизировать публикацию в developer portal.

### Продвинутый уровень

- управлять каталогом API-продуктов;
- проводить compatibility checks и quality gates;
- использовать docs-as-code и versioned portals.

## Сравнение форматов спецификаций

| Формат | Для чего лучше | Сильные стороны | Ограничения |
| --- | --- | --- | --- |
| OpenAPI 3.1 | [REST](../../glossary.md#abbr-071) API | экосистема, генерация SDK, linting | не описывает event-driven полноценно |
| RAML | REST design-first | удобен для моделирования API-first | меньше tooling, чем у OpenAPI |
| AsyncAPI | event/API over messaging | каналы, сообщения, bindings | ниже зрелость в отдельных инструментах |
| GraphQL SDL | GraphQL APIs | компактная схема и интроспекция | нужен отдельный governance на резолверы |
| Protobuf | [gRPC](../../glossary.md#abbr-036)/messaging | строгая типизация, бинарная эффективность | слабая читаемость без tooling |
| Avro IDL | Kafka schema registry | эволюция схем, serialization contracts | меньше удобства для [HTTP](../../glossary.md#abbr-038) API |

## Что должно быть в спецификации

- бизнес-назначение и потребители;
- операции и контракты (input/output/errors);
- аутентификация и авторизация;
- лимиты, идемпотентность, retry policy;
- [SLO](../../glossary.md#abbr-081)/[SLA](../../glossary.md#abbr-079) и observability поля (trace headers, correlation id);
- политика версий, deprecation и обратной совместимости.

## Пример REST endpoint (полный минимум)

```yaml
paths:
  /payments:
    post:
      operationId: createPayment
      summary: Create payment order
      security:
        - oauth2: [payments.write]
      parameters:
        - in: header
          name: Idempotency-Key
          required: true
          schema: { type: string }
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [orderId, amount, currency]
              properties:
                orderId: { type: string }
                amount: { type: number }
                currency: { type: string }
      responses:
        "201": { description: Created }
        "400": { description: Validation error }
        "429": { description: Rate limit exceeded }
```

## Пример GraphQL endpoint

```graphql
type Mutation {
  createPayment(input: PaymentInput!): PaymentResult!
}

input PaymentInput {
  orderId: ID!
  amount: Float!
  currency: String!
}

type PaymentResult {
  paymentId: ID!
  status: String!
}
```

## Code generation, mocks, contract tests

| [Задача](../../glossary.md#term-028) | Инструменты | Практика |
| --- | --- | --- |
| Генерация SDK/стабов | OpenAPI Generator, Swagger Codegen, protoc | генерируйте в [CI](../../glossary.md#abbr-016) и фиксируйте версии |
| Mock [API](../../glossary.md#abbr-005) | WireMock, MockServer, Prism | используйте для ранней интеграции front/back |
| Contract testing | Pact, Spring Cloud Contract | проверяйте provider-consumer до релиза |
| Публикация | Swagger [UI](../../glossary.md#abbr-091), Redocly, Stoplight | публикуйте changelog и deprecation notes |

## [CI/CD](../../glossary.md#abbr-017) для документации

1. Проверка синтаксиса (`spectral`, `openapi-cli`, `asyncapi validate`).
2. Проверка совместимости (`oasdiff`, `graphql-inspector`).
3. Генерация preview-портала для PR.
4. Публикация в каталог API после merge.
5. Нотификация клиентов при breaking/deprecation изменениях.

## Типичные ошибки

- документация обновляется после релиза, а не до него;
- в спецификации нет примеров ошибок и edge cases;
- отсутствуют migration notes и сроки sunset;
- не заданы требования безопасности по операциям.
## Стандарты и источники

- OpenAPI: <https://spec.openapis.org/oas/latest.html>
- AsyncAPI: <https://www.asyncapi.com/docs/reference/specification/latest>
- RAML: <https://github.com/raml-org/raml-spec>
- GraphQL SDL: <https://spec.graphql.org/>
- Protocol Buffers: <https://protobuf.dev/>
- Pact docs: <https://docs.pact.io/>
