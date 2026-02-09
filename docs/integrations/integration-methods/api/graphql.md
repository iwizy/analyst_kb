# GraphQL

GraphQL позволяет клиенту запрашивать только нужные поля и работать через единый endpoint.

## Базовые элементы

- schema;
- query;
- mutation;
- subscription;
- resolvers.

## Пример schema

```graphql
type Order {
  id: ID!
  status: String!
  amount: Float!
}

type Query {
  order(id: ID!): Order
}
```

## Пример запроса

```graphql
query GetOrder($id: ID!) {
  order(id: $id) {
    id
    status
    amount
  }
}
```

## Пример mutation

```graphql
mutation Refund($id: ID!) {
  refundOrder(orderId: $id) {
    id
    status
  }
}
```

## Достоинства

- точечная выборка полей;
- удобно для BFF и сложных UI;
- единый контракт для композиции данных.

## Ограничения

- сложнее кэширование;
- риск дорогих nested queries;
- требуется query complexity/rate limit контроль.

## Практические рекомендации

- вводить query depth и complexity limits;
- отключать introspection в публичном проде при необходимости;
- versioning делать через schema evolution и deprecation;
- добавлять persisted queries для защиты и производительности.

## Смежные материалы

- [Лимиты и квоты](../../api-design/rate-limiting.md)
- [Обратная совместимость](../../api-design/backward-compatibility.md)
