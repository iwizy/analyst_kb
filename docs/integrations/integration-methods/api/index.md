# API

API-подход выбирается по типу нагрузки, требованиям к контракту и экосистеме потребителей.

## Сравнение технологий

| Технология | Сильная сторона | Ограничение | Типичный сценарий |
| --- | --- | --- | --- |
| REST/HTTP | простота и массовая совместимость | over/under-fetching | публичные и партнерские API |
| GraphQL | гибкая выборка данных | сложность кэширования и лимитов | BFF, сложные UI |
| gRPC | высокая производительность, стриминг | сложнее для браузера | service-to-service |
| JSON-RPC | простой RPC-контракт | меньше стандартных практик governance | внутренние RPC |
| SOAP | строгий enterprise-контракт | тяжелее и сложнее | legacy/B2B enterprise |
| WebSockets | full-duplex realtime | сложнее масштабирование соединений | realtime updates |

## Практическое правило

- внешний API: чаще REST или GraphQL;
- межсервисный internal API: чаще gRPC;
- enterprise B2B/legacy: SOAP;
- realtime каналы: WebSockets.

## Переход к подразделам

- [REST/HTTP(S)](rest-http.md)
- [GraphQL](graphql.md)
- [gRPC](grpc.md)
- [JSON-RPC](json-rpc.md)
- [SOAP](soap.md)
- [WebSockets](websockets.md)
