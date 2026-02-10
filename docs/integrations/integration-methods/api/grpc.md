# gRPC

> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)


gRPC оптимален для межсервисного взаимодействия с высокой нагрузкой и строгими контрактами.

## Уровни сложности

### Базовый уровень

- описывать сервисы в `.proto`;
- использовать unary вызовы;
- обрабатывать gRPC status codes.

### Средний уровень

- применять streaming режимы;
- внедрять interceptors (auth, logging, tracing);
- проектировать backward-compatible proto эволюцию.

### Продвинутый уровень

- использовать gRPC Gateway/grpc-web для внешних клиентов;
- оптимизировать latency (connection pooling, compression);
- управлять сервис-дискавери и load balancing на платформенном уровне.

## Пример proto

```proto
syntax = "proto3";
package payments.v1;

message CreatePaymentRequest {
  string order_id = 1;
  double amount = 2;
}

message CreatePaymentResponse {
  string payment_id = 1;
  string status = 2;
}

service PaymentsService {
  rpc CreatePayment(CreatePaymentRequest) returns (CreatePaymentResponse);
}
```

## Типы вызовов

| Тип | Когда использовать |
| --- | --- |
| Unary | обычный request/response |
| Server streaming | сервер отправляет поток результатов |
| Client streaming | клиент отправляет поток данных |
| Bidirectional streaming | двусторонний поток в реальном времени |

## Безопасность и observability

- TLS/mTLS для всех каналов;
- interceptors для auth, audit, correlation id;
- status codes и retry policies согласованы между командами;
- distributed tracing через OpenTelemetry.

## Ограничения

- сложнее для внешних браузерных клиентов без grpc-web;
- требует дисциплины в versioning proto;
- бинарный формат менее удобен для ручной диагностики.

## Типичные ошибки

- переиспользование field number после удаления поля;
- отсутствие deadlines и timeouts;
- неразделение internal/external API;
- игнорирование backward compatibility при изменении proto.
## Стандарты и источники

- gRPC docs: <https://grpc.io/docs/>
- Protocol Buffers guide: <https://protobuf.dev/programming-guides/proto3/>
- grpc-web: <https://github.com/grpc/grpc-web>
