# Идемпотентность

Идемпотентность гарантирует, что повторный запрос не создаст дубликат эффекта. Это критично для платежей, заказов, бронирований и асинхронных операций.

## Уровни сложности

### Базовый уровень

- понимать, какие HTTP-методы идемпотентны по семантике;
- применять `Idempotency-Key` для create-операций;
- возвращать одинаковый результат на повтор.

### Средний уровень

- хранить результат выполнения и payload hash;
- поддерживать TTL, дедупликацию и корреляцию запросов;
- распространять идемпотентность на очереди и события.

### Продвинутый уровень

- решать race conditions в кластере;
- реализовать exactly-once where feasible;
- связывать idempotency с outbox/inbox и distributed locks.

## Где нужна идемпотентность

| Сценарий | Риск без идемпотентности |
| --- | --- |
| Создание платежа | двойное списание |
| Создание заказа | дубли в OMS и fulfillment |
| Публикация события | повторные side-effects в downstream |
| Batch import | множественные записи при повторном запуске |

## Шаблон реализации

1. Клиент отправляет `Idempotency-Key`.
2. Сервер вычисляет `payload hash`.
3. Проверяется ключ в хранилище (Redis/DB).
4. Если ключ найден и hash совпадает, возвращается сохраненный ответ.
5. Если ключ найден и hash не совпадает, возвращается ошибка конфликта.
6. При первом выполнении результат и статус сохраняются с TTL.

## Поток обработки

```kroki-plantuml
@startuml
actor Client
participant API
database Store

Client -> API: POST /payments + Idempotency-Key
API -> Store: lookup(key)
alt key exists
  API -> Store: compare payload hash
  alt hash match
    API -> Store: load previous response
    API --> Client: previous response
  else hash mismatch
    API --> Client: 409 conflict
  end
else new key
  API -> API: process business operation
  API -> Store: save response with TTL
  API --> Client: 201 created
end
@enduml
```

## Pseudo-code (Java/Spring)

```java
String key = req.header("Idempotency-Key");
String hash = sha256(req.body());
Record r = repo.find(key);
if (r != null && r.hash.equals(hash)) return r.response;
if (r != null && !r.hash.equals(hash)) throw conflict();
Response out = service.process(req);
repo.save(key, hash, out, ttlHours);
return out;
```

## Pseudo-code (Node.js/Express)

```javascript
const key = req.get('Idempotency-Key');
const hash = sha256(JSON.stringify(req.body));
const rec = await store.get(key);
if (rec && rec.hash === hash) return res.status(rec.status).json(rec.body);
if (rec && rec.hash !== hash) return res.status(409).json({ error: 'payload mismatch' });
const out = await processBusiness(req.body);
await store.put(key, { hash, status: 201, body: out }, ttlSec);
return res.status(201).json(out);
```

## Конкурентность и кластер

| Проблема | Решение |
| --- | --- |
| Два узла одновременно обрабатывают один ключ | distributed lock или atomic upsert |
| Репликация отстает | писать/читать idempotency store в primary |
| Повтор в очереди | dedup key в consumer + inbox pattern |
| Повтор после TTL | TTL по бизнес-окну риска, а не минимально возможный |

## Идемпотентность и MQ

- producer использует transactional outbox;
- consumer хранит processed-message-id (inbox);
- side-effects выполняются после проверки dedup;
- retry не должен менять бизнес-эффект.

## Типичные ошибки

- хранение только ключа без payload hash;
- слишком короткий TTL для финансовых операций;
- повтор non-idempotent операций в retry без ключа;
- отсутствие наблюдаемости по конфликтам идемпотентности.
## Стандарты и источники

- RFC 9110 (Idempotent Methods): <https://www.rfc-editor.org/rfc/rfc9110>
- Stripe idempotency practice: <https://docs.stripe.com/idempotency>
- Transactional Outbox pattern: <https://microservices.io/patterns/data/transactional-outbox.html>
