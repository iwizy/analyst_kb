# JSON

JSON это де-факто формат обмена данными в HTTP API.

## Сильные стороны

- компактный и широко поддерживаемый;
- удобен для JavaScript/TypeScript клиентов;
- хорошо сочетается с OpenAPI и JSON Schema.

## Ограничения

- нет встроенной типобезопасности на уровне транспорта;
- нет комментариев;
- бинарные данные передаются неэффективно (base64).

## Пример payload

```json
{
  "order_id": "ORD-100245",
  "status": "paid",
  "amount": 4950.0,
  "items": [
    {"sku": "SKU-1", "qty": 1, "price": 4200.0},
    {"sku": "SKU-2", "qty": 1, "price": 750.0}
  ]
}
```

## JSON Schema пример

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "required": ["order_id", "status", "amount"],
  "properties": {
    "order_id": {"type": "string"},
    "status": {"type": "string", "enum": ["draft", "paid", "cancelled"]},
    "amount": {"type": "number", "minimum": 0}
  }
}
```

## Практические рекомендации

- не использовать float для денег без договоренности о precision;
- фиксировать timezone формат (`ISO-8601`);
- не менять тип поля без новой версии;
- добавлять schema validation в CI/CD.
