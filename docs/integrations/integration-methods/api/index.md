# API

Подраздел сравнивает основные API-подходы: REST, SOAP, GraphQL, gRPC, JSON-RPC и WebSockets.

## Уровни сложности

### Базовый уровень

- понимать базовую модель каждого API-стиля;
- выбирать стиль по типу клиента и сценария;
- проектировать простые контракты и ошибки.

### Средний уровень

- учитывать caching, pagination, streaming и security;
- комбинировать API-стили в одной архитектуре;
- управлять версионированием и совместимостью.

### Продвинутый уровень

- проектировать API portfolio с governance;
- оценивать TCO и эксплуатационные риски каждого подхода;
- внедрять observability и performance optimization под стиль API.

## Сравнение технологий

| API-стиль | Подходит для | Сильные стороны | Ограничения |
| --- | --- | --- | --- |
| REST/HTTP | публичные и BFF API | простота, стандартная веб-инфраструктура | over/under-fetching |
| SOAP | enterprise и legacy B2B | WS-* стандарты, строгие контракты | сложность и объем |
| GraphQL | frontend aggregation | гибкая выборка данных | сложность governance и кеша |
| gRPC | internal service-to-service | низкая latency, строгость proto | сложнее для браузера/партнеров |
| JSON-RPC | command style APIs | компактность и batch | менее выраженная ресурсная модель |
| WebSockets | realtime и bidirectional | push в реальном времени | состояние соединений и scaling |

## Практическое правило выбора

1. Публичный API для внешних клиентов: чаще REST.
2. Межсервисный low-latency: чаще gRPC.
3. UI с разными сценариями выборки: GraphQL.
4. Legacy enterprise и strict contracts: SOAP.
5. Realtime push: WebSockets.

## Переход к подразделам

- [REST/HTTP(S)](rest-http.md)
- [SOAP](soap.md)
- [GraphQL](graphql.md)
- [gRPC](grpc.md)
- [JSON-RPC](json-rpc.md)
- [WebSockets](websockets.md)

## Контрольные вопросы

1. Какой профиль потребителей и их ограничения (browser/mobile/backend)?
2. Какие нефункциональные требования критичны: latency, throughput, security?
3. Нужен ли streaming, bidirectional канал или batch?
4. Какие риски совместимости у выбранного API-стиля?

## Чек-лист самопроверки

- API-стиль выбран под конкретный сценарий;
- определены правила ошибок, версий и безопасности;
- учтены ограничения tooling и эксплуатации;
- предусмотрен план миграции и мониторинга;
- есть документация и примеры для потребителей.

## Стандарты и источники

- RFC 9110 HTTP: <https://www.rfc-editor.org/rfc/rfc9110>
- GraphQL Spec: <https://spec.graphql.org/>
- gRPC docs: <https://grpc.io/docs/>
- JSON-RPC 2.0: <https://www.jsonrpc.org/specification>
