# GraphQL

GraphQL эффективен, когда клиентам нужны гибкие выборки и агрегация данных из нескольких источников.

## Уровни сложности

### Базовый уровень

- понимать SDL, Query, Mutation;
- проектировать базовые типы и резолверы;
- ограничивать поля, доступные клиенту.

### Средний уровень

- решать проблему N+1 и настраивать DataLoader;
- внедрять кеширование, persisted queries и depth limiting;
- поддерживать schema evolution и deprecation.

### Продвинутый уровень

- использовать federation/schema stitching;
- строить BFF на GraphQL с governance и security;
- оптимизировать производительность сложных графов запросов.

## Базовые элементы

| Элемент | Назначение |
| --- | --- |
| SDL | описание типов, полей и операций |
| Query | получение данных |
| Mutation | изменение данных |
| Resolver | бизнес-логика получения поля |
| Subscription | realtime-обновления |

## Пример schema

```graphql
type Product {
  id: ID!
  name: String!
  price: Float!
}

type Query {
  product(id: ID!): Product
  products(limit: Int = 20): [Product!]!
}
```

## Пример запроса

```graphql
query GetProduct {
  product(id: "p-10") {
    id
    name
    price
  }
}
```

## N+1 и DataLoader

- проблема: для списка сущностей выполняется отдельный запрос на каждую связанную сущность;
- решение: batch-loading и кеш в пределах запроса;
- дополнительно: ограничение `max depth` и `max complexity`.

## Federation и BFF

- Federation позволяет объединять схемы доменных сервисов в единый supergraph;
- BFF поверх GraphQL упрощает фронтенд-агрегацию;
- важно задавать ownership полей и правила согласования schema changes.

## Типичные ошибки

- отсутствие ограничений глубины/сложности запросов;
- schema drift из-за слабого governance;
- перегрузка одного endpoint без rate limiting;
- прямой доступ к внутренней доменной модели без boundary.

## Контрольные вопросы

1. Для каких клиентов GraphQL действительно снижает число вызовов?
2. Решена ли N+1 проблема в ключевых query?
3. Какие лимиты стоят на depth/complexity?
4. Как устроена совместимость и deprecation полей?

## Чек-лист самопроверки

- схема и резолверы документированы;
- внедрены DataLoader и query limits;
- настроены authz и rate limits по операциям;
- есть процесс эволюции схемы;
- observability собирает метрики по полям и операциям.

## Стандарты и источники

- GraphQL Spec: <https://spec.graphql.org/>
- Apollo Federation docs: <https://www.apollographql.com/docs/federation>
- GraphQL over HTTP: <https://graphql.github.io/graphql-over-http/>
