# JSON-RPC

JSON-RPC это протокол удаленного вызова процедур в JSON-формате.

## Базовая модель

Запрос:

```json
{
  "jsonrpc": "2.0",
  "method": "order.get",
  "params": {"order_id": "ORD-100245"},
  "id": "req-1"
}
```

Ответ:

```json
{
  "jsonrpc": "2.0",
  "result": {
    "order_id": "ORD-100245",
    "status": "paid"
  },
  "id": "req-1"
}
```

Ошибка:

```json
{
  "jsonrpc": "2.0",
  "error": {
    "code": -32602,
    "message": "Invalid params"
  },
  "id": "req-1"
}
```

## Batch request

```json
[
  {"jsonrpc": "2.0", "method": "order.get", "params": {"order_id": "ORD-1"}, "id": 1},
  {"jsonrpc": "2.0", "method": "order.get", "params": {"order_id": "ORD-2"}, "id": 2}
]
```

## Достоинства

- простой и компактный RPC-контракт;
- удобно для внутренних сервисов;
- легко сериализуется в JSON.

## Ограничения

- меньше общепринятых governance-конвенций, чем у REST;
- требуется собственная модель маршрутизации/ошибок;
- кэширование и observability нужно проектировать отдельно.

## Практические рекомендации

- стандартизировать namespace методов (`domain.action`);
- использовать correlation id и trace id;
- фиксировать retry/idempotency правила в контракте;
- ограничивать batch size и payload size.

## Смежные материалы

- [Идемпотентность](../../api-design/idempotency.md)
- [Паттерны надежности](../reliability-patterns.md)
