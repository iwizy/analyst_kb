# Идемпотентность

Идемпотентность гарантирует, что повторный запрос не создаст дополнительные побочные эффекты. Это критично при retry из-за timeout/сетевых сбоев.

## HTTP и идемпотентность

По стандартной семантике:

- идемпотентные: `GET`, `PUT`, `DELETE`;
- неидемпотентные: `POST`, `PATCH` (по умолчанию).

На практике `POST` часто делают идемпотентным через `Idempotency-Key`.

## Idempotency-Key pattern

### Запрос

```http
POST /v1/payments
Idempotency-Key: 7ea6c4d0-0a1c-4d4d-8df2-3ef1f1b14dc8
Content-Type: application/json
```

```json
{
  "order_id": "ORD-100245",
  "amount": 4950,
  "currency": "RUB"
}
```

### Поведение сервера

1. Проверить ключ в idempotency storage.
1. Если ключ новый: выполнить операцию, сохранить результат.
1. Если ключ уже использован: вернуть ранее сохраненный ответ.

## Диаграмма потока

```kroki-plantuml
@startuml
actor Client
participant API
database Store as "Idempotency Store"

Client -> API: POST /payments (Idempotency-Key=K)
API -> Store: lookup(K)
Store --> API: not found
API -> API: execute payment
API -> Store: save(K, response)
API --> Client: 201 Created

Client -> API: RETRY POST /payments (K)
API -> Store: lookup(K)
Store --> API: found response
API --> Client: same 201 response
@enduml
```

## Практические детали

- TTL ключа (например, 24 часа) фиксировать в контракте;
- ключ должен быть уникален на business-operation;
- хранить digest payload, чтобы отловить reuse ключа с другим телом;
- возвращать явную ошибку при конфликте ключ/пэйлоад.

## Типичные ошибки

- не хранить результат операции для повторной выдачи;
- использовать слишком короткий TTL;
- не защищать хранилище от race condition;
- выполнять non-idempotent side effects до записи ключа.

## Смежные материалы

- [Лимиты и квоты](rate-limiting.md)
- [Паттерны надежности](../integration-methods/reliability-patterns.md)
