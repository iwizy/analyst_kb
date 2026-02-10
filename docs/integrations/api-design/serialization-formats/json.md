# JSON

JSON остается основным форматом для публичных API благодаря читаемости и универсальной поддержке.

## Уровни сложности

### Базовый уровень

- валидировать JSON по схеме;
- использовать однозначные типы и nullable-правила;
- документировать примеры запросов/ответов.

### Средний уровень

- управлять эволюцией JSON-схем;
- контролировать size payload и глубину вложенности;
- применять `ETag`, `Cache-Control` и partial responses.

### Продвинутый уровень

- оптимизировать JSON для high-load (streaming, compression);
- выстраивать совместимость в multi-client API;
- автоматизировать schema linting и drift detection.

## JSON Schema vs OpenAPI Schema

| Критерий | JSON Schema | OpenAPI Schema |
| --- | --- | --- |
| Назначение | универсальная валидация JSON | описание API-контрактов |
| Экосистема | широкий набор валидаторов | тесно интегрировано с API tooling |
| Особенности | богатые ограничения и композиции | удобно для endpoint-документации |

## Пример payload

```json
{
  "orderId": "ord-1001",
  "customerId": "c-42",
  "items": [
    { "sku": "A-1", "qty": 2, "price": 10.5 }
  ],
  "total": 21.0,
  "createdAt": "2026-02-10T12:30:00Z"
}
```

## Пример JSON Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "required": ["orderId", "items", "total"],
  "properties": {
    "orderId": { "type": "string" },
    "items": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["sku", "qty"],
        "properties": {
          "sku": { "type": "string" },
          "qty": { "type": "integer", "minimum": 1 }
        }
      }
    },
    "total": { "type": "number", "minimum": 0 }
  }
}
```

## Performance considerations

- включайте gzip/brotli для больших payload;
- ограничивайте max body size;
- избегайте глубоких вложенностей и избыточных полей;
- для стриминга используйте NDJSON, когда нужен поток событий.

## Типичные ошибки

- неявные nullable-поля без семантики;
- drift между документацией и фактическим payload;
- использование строк вместо типизированных чисел/дат;
- неконтролируемый рост payload при backward-совместимых расширениях.
## Стандарты и источники

- RFC 8259 JSON: <https://www.rfc-editor.org/rfc/rfc8259>
- JSON Schema: <https://json-schema.org/specification>
- OpenAPI 3.1: <https://spec.openapis.org/oas/latest.html>
