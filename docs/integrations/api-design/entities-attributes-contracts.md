# Сущности, атрибуты, контракты

[Контракт](../../glossary.md#term-038) [API](../../glossary.md#abbr-005) должен отражать доменную модель и бизнес-правила, а не только формат JSON. Ошибки на этом шаге приводят к дорогим миграциям и несовместимости между командами.

## Уровни сложности

### Базовый уровень

- выделять сущности, атрибуты и связи;
- фиксировать обязательные и опциональные поля;
- задавать единые правила именования.

### Средний уровень

- проектировать bounded contexts и агрегаты;
- различать internal model и external API model;
- использовать contract-first и schema linting.

### Продвинутый уровень

- управлять эволюцией схем в распределенной системе;
- внедрять data contracts и ownership модели;
- строить multi-format контракты ([REST](../../glossary.md#abbr-071) + events + [gRPC](../../glossary.md#abbr-036)).

## Как выявлять сущности и атрибуты

### Шаги

1. Определите bounded context и границы ответственности сервиса.
2. Выделите агрегаты и invariants (что должно быть атомарно).
3. Зафиксируйте canonical attributes: идентификаторы, статусы, бизнес-даты.
4. Опишите жизненный цикл сущности: create/update/close.
5. Разведите поля по зонам: required, optional, computed, deprecated.

### Мини-шаблон сущности

| Поле | Описание |
| --- | --- |
| Entity name | Доменное имя (`Order`, `Invoice`) |
| Owner | Команда-владелец |
| Business invariant | Набор правил целостности |
| Required attributes | Минимум для корректной операции |
| [PII](../../glossary.md#abbr-063)/Sensitive | Флаги чувствительных данных |
| Versioning rule | Правила эволюции полей |

## Шаблон API-контракта

| Раздел | Что фиксировать |
| --- | --- |
| Назначение | бизнес-цель и потребители |
| Операции | методы/эндпоинты/queries/mutations |
| Схемы request/response | обязательность, типы, enum |
| Ошибки | коды, условия, retryability |
| Безопасность | authn/authz, scopes, [mTLS](../../glossary.md#abbr-052) |
| Лимиты | rate limit, quota, burst |
| Совместимость | version, deprecation, sunset |
| Нефункциональные требования | latency, availability, idempotency |

## Примеры контрактов в разных стилях

### REST/OpenAPI (фрагмент)

```yaml
openapi: 3.1.0
info:
  title: Orders API
  version: 1.4.0
paths:
  /orders/{orderId}:
    get:
      operationId: getOrder
      parameters:
        - name: orderId
          in: path
          required: true
          schema: { type: string }
      responses:
        "200":
          description: Order found
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Order"
        "404":
          description: Not found
components:
  schemas:
    Order:
      type: object
      required: [id, status, total]
      properties:
        id: { type: string }
        status: { type: string, enum: [NEW, PAID, SHIPPED, CANCELED] }
        total: { type: number }
```

### GraphQL SDL (фрагмент)

```graphql
type Order {
  id: ID!
  status: OrderStatus!
  total: Float!
  updatedAt: String!
}

enum OrderStatus { NEW PAID SHIPPED CANCELED }

type Query {
  order(id: ID!): Order
}
```

### [gRPC](../../glossary.md#abbr-036)/proto (фрагмент)

```proto
syntax = "proto3";
package orders.v1;

message GetOrderRequest { string id = 1; }
message Order {
  string id = 1;
  string status = 2;
  double total = 3;
}
service OrdersService {
  rpc GetOrder(GetOrderRequest) returns (Order);
}
```

### JSON-RPC 2.0 (пример)

```json
{
  "jsonrpc": "2.0",
  "method": "order.get",
  "params": { "id": "ord-1001" },
  "id": "req-77"
}
```

### [SOAP](../../glossary.md#abbr-083)/WSDL (сокращенный пример)

```xml
<wsdl:operation name="GetOrder">
  <wsdl:input message="tns:GetOrderRequest"/>
  <wsdl:output message="tns:GetOrderResponse"/>
</wsdl:operation>
```

## Contract-first vs code-first

| Подход | Плюсы | Минусы | Когда выбирать |
| --- | --- | --- | --- |
| Contract-first | прогнозируемость, рано выявляет конфликты | выше порог запуска | multi-team, внешние [API](../../glossary.md#abbr-005) |
| Code-first | быстрый старт | риск drift между кодом и документацией | внутренний прототип, low risk |

## [[CI](../../glossary.md#abbr-016)/CD](../../glossary.md#abbr-017) для контрактов

- pull request на контракт обязателен до кода;
- линтеры: `spectral`, `openapi-cli`, `buf`;
- diff-проверки: `oasdiff`, `swagger-diff`, `graphql-inspector`;
- contract tests: PACT/WireMock;
- публикация артефактов контракта в registry.

## Типичные ошибки

- смешение доменной модели и внутренней DTO-структуры сервиса;
- отсутствие owner и [SLA](../../glossary.md#abbr-079) у контракта;
- внедрение breaking-change без migration guide;
- неявные поля (nullable без описания причин);
- разные значения enum в синхронных и асинхронных контрактах.
## Стандарты и источники

- Domain-Driven Design Reference: <https://www.domainlanguage.com/ddd/reference/>
- OpenAPI: <https://spec.openapis.org/oas/latest.html>
- GraphQL: <https://spec.graphql.org/>
- Protocol Buffers: <https://protobuf.dev/>
- WSDL 1.1 note: <https://www.w3.org/TR/wsdl>
