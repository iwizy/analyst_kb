# API Gateway и Service Mesh

Gateway и service mesh решают разные слои задач. Gateway управляет входящим API-трафиком, mesh - сервисным east-west трафиком внутри платформы.

## API Gateway

Решает:

- маршрутизацию и агрегацию API;
- authN/authZ, rate limiting, quota;
- версионирование и policy enforcement.

## Service Mesh

Решает:

- mTLS между сервисами;
- retry/timeout/circuit policy на уровне сети;
- traffic shaping (canary, blue/green);
- телеметрию и distributed tracing.

## Как сочетать

- north-south трафик через Gateway;
- east-west трафик через Mesh;
- единые политики безопасности и observability.

## Типичные ошибки

- дублирование ответственности между gateway и приложением;
- внедрение mesh без платформенной поддержки;
- отсутствие единой модели политик.
