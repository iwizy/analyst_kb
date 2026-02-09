# Сущности, атрибуты, контракты

Основа API-дизайна это корректная модель предметной области и стабильный контракт.

## Сущности

Сущность отражает бизнес-объект: `Customer`, `Order`, `Invoice`.

Критерии хорошей сущности:

- четкая ответственность;
- устойчивый идентификатор;
- прозрачный lifecycle (created, updated, archived).

## Атрибуты

Атрибуты делятся на группы:

- identity (`id`, `external_id`);
- business fields (`status`, `amount`);
- technical metadata (`created_at`, `updated_at`, `version`).

Пример:

```json
{
  "order_id": "ORD-2026-00045",
  "customer_id": "CUS-932",
  "status": "paid",
  "amount": 4950.00,
  "currency": "RUB",
  "created_at": "2026-02-09T10:15:00Z"
}
```

## Контракт API

Контракт определяет:

- операции (методы/процедуры);
- схемы запросов/ответов;
- коды и формат ошибок;
- условия авторизации;
- ограничения (rate limit, размер payload, timeout).

## Пример контракта endpoint

```http
POST /v1/orders
Authorization: Bearer <token>
Idempotency-Key: 63a8b8f4-6d67-4f11-9b67-1c6758d4f943
Content-Type: application/json
```

```json
{
  "customer_id": "CUS-932",
  "items": [
    {"sku": "SKU-1", "qty": 1, "price": 4200},
    {"sku": "SKU-2", "qty": 1, "price": 750}
  ]
}
```

## Ошибки контракта

Рекомендуемый единый формат ошибок:

```json
{
  "error": {
    "code": "ORDER_VALIDATION_FAILED",
    "message": "Item price must be positive",
    "trace_id": "4ed5f2f5d3"
  }
}
```

## Практические рекомендации

- не смешивать transport-level и business-level ошибки;
- указывать nullable/required явно;
- фиксировать enum и его эволюцию;
- добавлять примеры happy-path и negative-path в контракт.

## Смежные материалы

- [Документирование API (OpenAPI, RAML)](api-documentation.md)
- [Обратная совместимость](backward-compatibility.md)
