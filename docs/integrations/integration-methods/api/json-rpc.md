# JSON-RPC

JSON-RPC подходит для command-oriented интеграций и простых RPC-вызовов поверх HTTP/WebSocket.

## Уровни сложности

### Базовый уровень

- понимать структуру `jsonrpc`, `method`, `params`, `id`;
- различать request, response и notification;
- корректно формировать ошибки.

### Средний уровень

- использовать batch-запросы;
- проектировать namespace методов;
- обеспечивать идемпотентность команд.

### Продвинутый уровень

- внедрять routing, auth и observability на gateway;
- управлять версионностью методов и schema evolution;
- строить high-throughput RPC через persistent transport.

## Базовая модель

### Request

```json
{
  "jsonrpc": "2.0",
  "method": "invoice.get",
  "params": { "id": "inv-101" },
  "id": "req-1"
}
```

### Response

```json
{
  "jsonrpc": "2.0",
  "result": {
    "id": "inv-101",
    "status": "PAID"
  },
  "id": "req-1"
}
```

### Error

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

### Notification (без `id`)

```json
{
  "jsonrpc": "2.0",
  "method": "events.publish",
  "params": { "type": "ORDER_CREATED" }
}
```

## Batch request

```json
[
  { "jsonrpc": "2.0", "method": "order.get", "params": { "id": "o1" }, "id": 1 },
  { "jsonrpc": "2.0", "method": "order.get", "params": { "id": "o2" }, "id": 2 }
]
```

## Практические рекомендации

- используйте method namespaces (`orders.create`, `orders.cancel`);
- фиксируйте таблицу error codes и retryability;
- применяйте idempotency key для команд create/pay;
- добавляйте correlation-id в transport headers.

## Типичные ошибки

- смешение transport errors и RPC errors;
- отсутствие version policy для методов;
- неограниченные batch-запросы без лимитов;
- отсутствие схемы params/result.
## Стандарты и источники

- JSON-RPC 2.0: <https://www.jsonrpc.org/specification>
