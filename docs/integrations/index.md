# Интеграции

Раздел дает практический фреймворк для проектирования, внедрения и сопровождения интеграций: от выбора типа взаимодействия до надежности, наблюдаемости и соответствия регуляторике.

## Уровни сложности

### Базовый уровень

- различать синхронные и асинхронные интеграции;
- выбирать базовый API-стиль под задачу;
- понимать минимальные требования к безопасности, ошибкам и SLA.

### Средний уровень

- проектировать контракты и версионирование без поломки клиентов;
- выбирать паттерны надежности (retry, timeout, circuit breaker, DLQ);
- проектировать интеграции через API Gateway, брокеры и файловый обмен.

### Продвинутый уровень

- строить интеграционные платформы (mesh, event backbone, API management);
- управлять совместимостью и миграциями в multi-team и multi-domain среде;
- внедрять observability, compliance и data governance для интеграций.

## Карта тем раздела

```kroki-plantuml
@startuml
left to right direction
rectangle "Presentation\nWeb Mobile BFF" as P
rectangle "API Gateway\nAuth Routing Policies" as G
rectangle "Service Mesh\nmTLS Telemetry Resilience" as M
rectangle "Integration Layer\nREST gRPC Events Files" as I
rectangle "Messaging and Storage\nKafka RabbitMQ DB Object Storage" as S
rectangle "Observability and Compliance\nTracing Audit Policies" as O

P --> G
G --> M
M --> I
I --> S
I --> O
@enduml
```

## Быстрый алгоритм выбора подхода

1. Зафиксируйте бизнес-сценарий и критичность операции.
2. Определите целевой SLA/SLO: latency, availability, RTO/RPO.
3. Оцените профиль нагрузки: RPS, burst, read/write ratio, объем сообщений.
4. Сформулируйте требования к консистентности: strict, bounded staleness, eventual.
5. Определите доверенную модель: внешний клиент, партнер, внутренний сервис.
6. Выберите паттерн взаимодействия: request/response, pub/sub, batch file, stream.
7. Зафиксируйте контракт, версионирование, observability и rollback-стратегию.

## Матрица выбора типа интеграции

| Критерий | Синхронный API | Асинхронные события | Файловый обмен |
| --- | --- | --- | --- |
| Latency | миллисекунды-секунды | секунды-минуты | минуты-часы |
| Согласованность | выше, но жестче связность | eventual consistency | обычно пакетная |
| Надежность | зависит от retry/timeout | выше через очередь и DLQ | зависит от SLA канала |
| Масштабирование | через горизонтальный scale API | через партиции/консьюмеры | через батчи и окна |
| Типовые кейсы | checkout, валидация лимита | уведомления, интеграция доменов | регламентный обмен с партнерами |

## Примеры по доменам

| Домен | B2C | B2B | Межсервисное взаимодействие |
| --- | --- | --- | --- |
| Fintech | мобильные платежи через REST + OAuth2 | ISO 20022 batch + SFTP/AS2 | antifraud events + scoring через Kafka |
| E-commerce | каталог и корзина через REST/GraphQL | поставщики через EDI/файлы | заказ-склад-доставка через Saga |
| Gov | портал услуг через API gateway | межведомственный обмен по SOAP/SMEV | события статусов заявлений через брокер |
| Media | контент API + CDN | лицензирование с партнерами по контрактам | stream событий просмотров в DWH |

## Ключевые метрики интеграций

| Метрика | Что показывает | Целевой контроль |
| --- | --- | --- |
| p95 latency | пользовательский опыт и SLA | контроль по endpoint и операции |
| Throughput | пропускная способность | контроль пиков и деградаций |
| Error rate | стабильность и корректность | алерты на рост 4xx/5xx |
| Retry success rate | эффективность восстановления | не ниже порога по критичным операциям |
| DLQ size/age | накопление проблемных сообщений | ограничение времени в DLQ |
| Contract drift | риск расхождения с документацией | проверка в CI/CD |

## Переход к подразделам

- [Проектирование API](api-design/index.md)
- [Способы интеграции и паттерны](integration-methods/index.md)
- [Сетевое взаимодействие](networking/index.md)

## Контрольные вопросы

1. Какие операции в вашей системе критичны к latency, а какие к надежной доставке?
2. Где допустима eventual consistency, а где нужна синхронная проверка?
3. Какой механизм rollback/compensation используется при частичных сбоях?
4. Какие SLO закреплены в контракте с внешними системами?
5. Есть ли единая политика версионирования и deprecation?

## Чек-лист самопроверки

- выбран тип интеграции под профиль нагрузки и SLA;
- определены security-требования и доверенная модель;
- контракт версии и политика совместимости формализованы;
- предусмотрены retry, timeout, circuit breaker, DLQ;
- настроены трассировка, метрики и audit-log.

## Стандарты и источники

- RFC 9110 HTTP Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- RFC 9457 Problem Details for HTTP APIs: <https://www.rfc-editor.org/rfc/rfc9457>
- OAuth 2.1 draft: <https://datatracker.ietf.org/doc/draft-ietf-oauth-v2-1/>
- OpenAPI Specification: <https://spec.openapis.org/oas/latest.html>
- AsyncAPI Specification: <https://www.asyncapi.com/docs/reference/specification/latest>
- Enterprise Integration Patterns: <https://www.enterpriseintegrationpatterns.com/>
