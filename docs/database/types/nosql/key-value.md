# Key-Value базы данных
Key-value БД предназначены для ultra-fast доступа по ключу и часто используются как кэш, session store и low-latency state storage.

## Уровни сложности

### Базовый

- операции `GET/SET/DEL`, TTL;
- выбор key naming strategy.

### Средний

- shard key design, eviction policy, replication lag;
- idempotency и atomic operations.

### Продвинутый

- multi-region кэширование, hot key mitigation, consistency tuning.

## Сценарии применения

| Сценарий | Пример |
| --- | --- |
| Сессии пользователей | `session:{userId}` |
| Кэш карточек товара | `product:{sku}` |
| [Ограничение](../../../glossary.md#term-050) rate limits | `ratelimit:{apiKey}:{minute}` |
| Feature flags | `flag:{service}:{feature}` |

## Примеры данных и операций

```text
SET session:1001 "{...}" EX 1800
GET session:1001
INCR ratelimit:client-77:2026-02-10T10:25
EXPIRE ratelimit:client-77:2026-02-10T10:25 60
```

## [Консистентность](../../../glossary.md#term-040) и целостность

- большинство KV систем оптимизированы под AP/low latency;
- read-after-write зависит от топологии и клиента;
- для критичных операций используйте CAS/transactions/Lua scripts (по возможностям системы).

Практики:

- idempotency key на write path;
- version token для optimistic updates;
- fallback на primary transactional store при miss/lag.

## Безопасность

- [TLS](../../../glossary.md#abbr-088) и auth token/ACL;
- запрет публичных endpoint без private network;
- шифрование снапшотов/персистентного слоя;
- аудит administrative команд.

## [Миграция](../../../glossary.md#term-045) из [SQL](../../../glossary.md#abbr-084)

1. Выделить набор "горячих" ключевых чтений.
2. Сформировать key schema и TTL policy.
3. Реализовать cache-aside или write-through паттерн.
4. Подключить метрики hit ratio и stale data incidents.

## Типовые ошибки

- использование KV как primary source of truth для сложных инвариантов;
- отсутствие TTL и контроля memory growth;
- hot keys без репликации/распределения;
- кэш без инвалидации при изменении данных.

## Практические рекомендации

1. Фиксируйте key convention и namespace policy.
2. Для каждого набора ключей задавайте TTL и owner.
3. Мониторьте cache hit ratio, eviction rate, hot keys.
4. Для критичных операций храните источник истины в [OLTP](../../../glossary.md#abbr-060) БД.
## Стандарты и источники

- Redis docs: <https://redis.io/docs/>
- DynamoDB docs: <https://docs.aws.amazon.com/amazondynamodb/>
