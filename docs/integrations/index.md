# Интеграции

Раздел дает практический фреймворк для проектирования, внедрения и сопровождения интеграций: от выбора типа взаимодействия до надежности, наблюдаемости и соответствия регуляторике.

## Уровни сложности

### Базовый уровень

- различать синхронные и асинхронные интеграции;
- выбирать базовый [API](../glossary.md#abbr-005)-стиль под задачу;
- понимать минимальные требования к безопасности, ошибкам и [SLA](../glossary.md#abbr-079).

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
2. Определите целевой [SLA](../glossary.md#abbr-079)/[SLO](../glossary.md#abbr-081): latency, availability, [RTO](../glossary.md#abbr-076)/[RPO](../glossary.md#abbr-074).
3. Оцените профиль нагрузки: [RPS](../glossary.md#abbr-075), burst, read/write ratio, объем сообщений.
4. Сформулируйте требования к консистентности: strict, bounded staleness, eventual.
5. Определите доверенную модель: внешний клиент, партнер, внутренний сервис.
6. Выберите паттерн взаимодействия: request/response, pub/sub, batch file, stream.
7. Зафиксируйте контракт, версионирование, observability и rollback-стратегию.

## Матрица выбора типа интеграции

| Критерий | Синхронный [API](../glossary.md#abbr-005) | Асинхронные события | Файловый обмен |
| --- | --- | --- | --- |
| Latency | миллисекунды-секунды | секунды-минуты | минуты-часы |
| Согласованность | выше, но жестче связность | eventual consistency | обычно пакетная |
| Надежность | зависит от retry/timeout | выше через очередь и DLQ | зависит от SLA канала |
| Масштабирование | через горизонтальный scale API | через партиции/консьюмеры | через батчи и окна |
| Типовые кейсы | checkout, валидация лимита | уведомления, интеграция доменов | регламентный обмен с партнерами |

## Примеры по доменам

| [Домен](../glossary.md#term-023) | B2C | B2B | Межсервисное взаимодействие |
| --- | --- | --- | --- |
| Fintech | мобильные платежи через [REST](../glossary.md#abbr-071) + OAuth2 | [ISO](../glossary.md#abbr-043) 20022 batch + SFTP/AS2 | antifraud events + scoring через Kafka |
| E-commerce | каталог и корзина через REST/GraphQL | поставщики через EDI/файлы | заказ-склад-доставка через Saga |
| Gov | портал услуг через API gateway | межведомственный обмен по [SOAP](../glossary.md#abbr-083)/SMEV | события статусов заявлений через брокер |
| Media | контент API + CDN | лицензирование с партнерами по контрактам | stream событий просмотров в [DWH](../glossary.md#abbr-029) |

## Ключевые метрики интеграций

| [Метрика](../glossary.md#term-044) | Что показывает | Целевой контроль |
| --- | --- | --- |
| p95 latency | пользовательский опыт и SLA | контроль по endpoint и операции |
| Throughput | пропускная способность | контроль пиков и деградаций |
| Error rate | стабильность и корректность | алерты на рост 4xx/5xx |
| Retry success rate | эффективность восстановления | не ниже порога по критичным операциям |
| DLQ size/age | накопление проблемных сообщений | ограничение времени в DLQ |
| Contract drift | риск расхождения с документацией | проверка в [CI/CD](../glossary.md#abbr-017) |

## Переход к подразделам

- [Проектирование API](api-design/index.md)
- [Способы интеграции и паттерны](integration-methods/index.md)
- [Сетевое взаимодействие](networking/index.md)
## Стандарты и источники

- [RFC](../glossary.md#abbr-072) 9110 [HTTP](../glossary.md#abbr-038) Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- RFC 9457 Problem Details for HTTP APIs: <https://www.rfc-editor.org/rfc/rfc9457>
- [OAuth](../glossary.md#abbr-056) 2.1 draft: <https://datatracker.ietf.org/doc/draft-ietf-oauth-v2-1/>
- OpenAPI Specification: <https://spec.openapis.org/oas/latest.html>
- AsyncAPI Specification: <https://www.asyncapi.com/docs/reference/specification/latest>
- Enterprise Integration Patterns: <https://www.enterpriseintegrationpatterns.com/>
