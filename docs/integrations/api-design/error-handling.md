# Обработка ошибок API

Единая модель ошибок снижает время диагностики и упрощает поведение клиентов при сбоях. Для интеграций важен не только код ошибки, но и контракт: retryability, idempotency, correlation и правила деградации.

## Уровни сложности

### Базовый уровень

- разделять клиентские и серверные ошибки;
- возвращать предсказуемый формат ошибки;
- передавать `traceId` для разбора инцидентов.

### Средний уровень

- фиксировать retryability по каждому коду;
- связывать ошибки с rate limit и idempotency;
- выравнивать формат ошибок между API-стилями.

### Продвинутый уровень

- внедрять централизованную error taxonomy;
- использовать policy-driven fallback и graceful degradation;
- строить аналитические дашборды по ошибкам и контрактным нарушениям.

## Базовая таксономия

| Класс | Смысл | Действие клиента |
| --- | --- | --- |
| Validation | некорректный входной запрос | исправить запрос, без retry |
| Auth/Authz | нет прав или токен невалиден | обновить токен/права, без blind retry |
| Business conflict | конфликт бизнес-правил | скорректировать состояние или команду |
| Rate limiting | превышены лимиты | retry после `Retry-After` |
| Dependency failure | проблема downstream | retry по policy + fallback |
| Internal error | непредвиденная ошибка сервиса | ограниченный retry + инцидент |

## REST/HTTP: рекомендуемый формат

Используйте `application/problem+json` (RFC 9457) и единые поля:

```json
{
  "type": "https://api.example.com/problems/payment-timeout",
  "title": "Downstream timeout",
  "status": 503,
  "detail": "Payment provider did not respond in 2s",
  "instance": "/payments/req-771",
  "traceId": "trc-9f2c",
  "retryable": true
}
```

## Retry matrix по кодам

| Код | Класс | Retry | Комментарий |
| --- | --- | --- | --- |
| 400 | Validation | нет | ошибка клиента |
| 401/403 | Auth/Authz | условно | после обновления токена/прав |
| 404 | Not found | нет | unless eventual-read model |
| 409 | Conflict | условно | после reconcile/idempotency check |
| 422 | Domain validation | нет | бизнес-валидация |
| 429 | Rate limit | да | c backoff + jitter |
| 500 | Internal | ограниченно | 1-3 попытки |
| 503/504 | Downstream unavailable/timeout | да | по policy и timeout budget |

## Ошибки в других API-стилях

### gRPC

- использовать status codes (`INVALID_ARGUMENT`, `UNAVAILABLE`, `DEADLINE_EXCEEDED`);
- передавать `error details` в metadata;
- синхронизировать retry policy с deadlines.

### GraphQL

- возвращать ошибки в массиве `errors`;
- добавлять `extensions.code`, `traceId`, `retryable`;
- не прятать критичные ошибки в `data: null` без пояснений.

### JSON-RPC

- фиксировать таблицу `error.code -> meaning -> retryability`;
- отделять transport error от business error.

### SOAP

- использовать корректные `SOAP Fault` коды;
- описывать fault-contract в WSDL/XSD;
- документировать retryability отдельно от faultstring.

## Idempotency + error handling

Для create/financial операций:

1. Клиент отправляет `Idempotency-Key`.
1. При timeout клиент делает retry с тем же ключом.
1. Сервер возвращает сохраненный результат или явный `409 payload mismatch`.

Это устраняет дубли эффектов при сетевых и транзитных сбоях.

## Частичные отказы и деградация

| Сценарий | Рекомендуемое поведение |
| --- | --- |
| Downstream медленный | timeout + cached/partial fallback |
| Невалидный фрагмент batch | partial success + список item-level ошибок |
| Недоступен вторичный сервис | graceful degradation и явный статус частичного результата |

## Минимальные метрики ошибок

- error rate по endpoint и коду;
- retry success rate;
- доля non-retryable ошибок, ошибочно ретраенных клиентом;
- latency до первого корректного ответа после ошибки;
- top error types за релиз.

## Типичные ошибки

- разные форматы ошибок в разных сервисах одной платформы;
- отсутствие `traceId` в ответах;
- retry на неретраемые ошибки (`4xx`);
- отсутствие миграции error-кодов при versioning API.

## Практические рекомендации

1. Утвердите единый error catalog на уровне платформы.
2. Включите проверку error schema в contract tests.
3. Храните retryability как часть контракта, а не «знание из командного чата».
4. Делайте отдельный дашборд по ошибкам интеграций и policy violations.
## Стандарты и источники

- RFC 9457 Problem Details for HTTP APIs: <https://www.rfc-editor.org/rfc/rfc9457>
- RFC 9110 HTTP Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- gRPC status codes: <https://grpc.io/docs/guides/status-codes/>
- JSON-RPC 2.0: <https://www.jsonrpc.org/specification>
