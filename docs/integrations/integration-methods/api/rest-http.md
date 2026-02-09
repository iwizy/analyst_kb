# REST/HTTP(S)

REST это архитектурный стиль работы с ресурсами через HTTP-методы, статусы и гипермедиа-ссылки.

## Принципы REST

- клиент-серверное разделение;
- stateless взаимодействие;
- cacheable responses;
- uniform interface;
- layered system.

## Ресурсная модель

- коллекция: `/v1/orders`
- экземпляр: `/v1/orders/{orderId}`

## HTTP-методы и семантика

- `GET` — чтение;
- `POST` — создание/команда;
- `PUT` — полная замена;
- `PATCH` — частичное обновление;
- `DELETE` — удаление.

## HATEOAS

HATEOAS добавляет в ответ ссылки на допустимые следующие действия.

```json
{
  "order_id": "ORD-100245",
  "status": "paid",
  "_links": {
    "self": {"href": "/v1/orders/ORD-100245"},
    "refund": {"href": "/v1/orders/ORD-100245/refund", "method": "POST"}
  }
}
```

## Коды ошибок и error model

Рекомендуется использовать RFC 7807 (`application/problem+json`).

```json
{
  "type": "https://api.example.com/errors/validation",
  "title": "Validation failed",
  "status": 400,
  "detail": "amount must be positive",
  "trace_id": "4ed5f2f5d3"
}
```

### Базовые статус-коды

- `200`, `201`, `202`, `204`;
- `400`, `401`, `403`, `404`, `409`, `422`, `429`;
- `500`, `502`, `503`, `504`.

## Практические рекомендации

- использовать `Idempotency-Key` для критичных `POST`;
- явно документировать retry semantics;
- не ломать контракт через silent changes;
- использовать ETag/If-None-Match для кэширования;
- сохранять предсказуемые error codes.

## Смежные материалы

- [Документирование API (OpenAPI, RAML)](../../api-design/api-documentation.md)
- [Идемпотентность](../../api-design/idempotency.md)
- [Обратная совместимость](../../api-design/backward-compatibility.md)
