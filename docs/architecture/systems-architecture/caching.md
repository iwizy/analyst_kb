# Кэширование

Кэширование снижает latency и нагрузку на backend, но требует явного управления актуальностью и инвалидацией данных.

## Уровни сложности

### Базовый уровень

- понимать зачем нужен кэш и где его размещать;
- выбирать TTL и базовую стратегию invalidation;
- измерять cache hit ratio.

### Средний уровень

- применять Cache-Aside/Read-through/Write-through;
- управлять consistency и stale данными;
- предотвращать cache stampede.

### Продвинутый уровень

- строить multi-layer cache (CDN + gateway + app + DB);
- оптимизировать eviction policies и warm-up;
- управлять кэшем в распределенной архитектуре.

## Виды кэширования

| Вид | Примеры | Когда использовать |
| --- | --- | --- |
| In-memory local | Caffeine, LRU/LFU | быстрый локальный доступ |
| Distributed cache | Redis, Memcached, Hazelcast | shared cache между инстансами |
| HTTP cache | Cache-Control, ETag | кэш на клиенте/CDN/proxy |
| CDN | CloudFront, Fastly, Akamai | статический/полустатический контент |

## Паттерны кэширования

| Паттерн | Идея | Плюсы | Риски |
| --- | --- | --- | --- |
| Cache-Aside | app читает cache, при miss идет в DB | гибкость | сложнее invalidation |
| Read-through | cache сам загружает данные | проще клиенту | зависимость от cache layer |
| Write-through | запись сразу в cache и storage | консистентность чтения | рост write latency |
| Write-behind | запись в storage асинхронно | быстрые writes | риск потери при сбое |
| Refresh-ahead | обновление до истечения TTL | меньше miss | лишний background load |

## Схема Cache-Aside

```kroki-plantuml
@startuml
actor Client
participant Service
database Cache
database DB
Client -> Service: get(key)
Service -> Cache: read
alt hit
  Cache --> Service: value
else miss
  Cache --> Service: miss
  Service -> DB: query
  DB --> Service: value
  Service -> Cache: set(key, value, ttl)
end
Service --> Client: value
@enduml
```

## TTL, invalidation, consistency

- TTL выбирайте по business tolerance к устареванию.
- Для критичных данных используйте event-based invalidation.
- Для отчетных/каталожных данных допустима eventual consistency.

## Cache stampede защита

- request coalescing/single-flight;
- jitter к TTL;
- stale-while-revalidate;
- rate limiting на backend fallback.

## Технологический выбор

| Выбор | Когда лучше | Ограничения |
| --- | --- | --- |
| Redis | богатый функционал, pub/sub, persistence | выше memory cost |
| Memcached | простой и быстрый volatile cache | меньше возможностей |
| Hazelcast | in-memory data grid JVM | сложнее эксплуатация |

## Типичные ошибки

- один TTL для всех сущностей;
- отсутствие метрик hit/miss/eviction;
- write-behind без durability механизма;
- кэширование чувствительных данных без политики security.
## Стандарты и источники

- Redis docs: <https://redis.io/docs/>
- HTTP caching RFC 9111.
- CDN best practices vendor docs.
