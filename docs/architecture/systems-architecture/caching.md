# Кэширование

Кэширование снижает latency и нагрузку на backend, но требует аккуратной работы
с актуальностью данных.

## Основные стратегии

- Cache-aside;
- Read-through / Write-through;
- Write-back;
- TTL + invalidation по событию.

## Пример слоя кэширования

```kroki-plantuml
@startuml
actor User
participant API
database Redis
database DB

User --> API : GET /profile
API --> Redis : read key
alt cache hit
  Redis --> API : data
else cache miss
  API --> DB : query
  DB --> API : data
  API --> Redis : set key (TTL)
end
API --> User : response
@enduml
```

## Чек-лист качества

- Понятны правила инвалидации.
- Cache miss не ломает SLA критично.
- Мониторятся hit ratio и stale data incidents.
