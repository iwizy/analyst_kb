# gRPC

gRPC это высокопроизводительный RPC-фреймворк на базе HTTP/2 и Protocol Buffers.

## Почему выбирают gRPC

- компактный бинарный протокол;
- codegen для строгих контрактов;
- поддержка unary и streaming вызовов;
- хорош для service-to-service в микросервисах.

## Пример proto

```proto
syntax = "proto3";

service OrderService {
  rpc GetOrder (GetOrderRequest) returns (OrderResponse);
  rpc StreamOrders (StreamOrdersRequest) returns (stream OrderResponse);
}

message GetOrderRequest { string order_id = 1; }
message StreamOrdersRequest { string customer_id = 1; }
message OrderResponse {
  string order_id = 1;
  string status = 2;
  double amount = 3;
}
```

## Виды вызовов

- unary;
- server streaming;
- client streaming;
- bidirectional streaming.

## Безопасность

- TLS/mTLS;
- JWT/OAuth2 metadata;
- per-method authz policies.

## Ограничения

- в браузере обычно нужен grpc-web прокси;
- сложнее отладка без специализированных инструментов;
- careful versioning protobuf-схем обязателен.

## Практические рекомендации

- не переиспользовать номера полей в proto;
- использовать deadlines/timeouts;
- включать retry policies осознанно;
- документировать backward-compatible правила эволюции proto.

## Смежные материалы

- [Безопасность API (OAuth 2.0, JWT, mTLS)](../../api-design/security.md)
- [Паттерны надежности](../reliability-patterns.md)
