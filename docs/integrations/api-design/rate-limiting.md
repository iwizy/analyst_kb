# Лимиты и квоты

Rate limiting защищает API от перегрузки и злоупотреблений, а квоты обеспечивают предсказуемое распределение ресурсов между потребителями.

## Типы ограничений

- per-client RPS;
- per-token/per-user;
- burst + sustained limits;
- daily/monthly quota;
- лимиты на тяжелые операции.

## Алгоритмы

- Token Bucket: гибкий контроль burst.
- Leaky Bucket: выравнивание потока.
- Fixed Window: просто, но может давать spikes на границах окна.
- Sliding Window: более точный контроль.

## HTTP-практика

Статус и заголовки:

- `429 Too Many Requests`
- `Retry-After`
- `X-RateLimit-Limit`
- `X-RateLimit-Remaining`
- `X-RateLimit-Reset`

Пример:

```http
HTTP/1.1 429 Too Many Requests
Retry-After: 30
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1739092800
```

## Дизайн лимитов

1. Классифицировать endpoints по "стоимости".
1. Ввести разные профили лимитов (free/partner/internal).
1. Отдельно контролировать write-heavy операции.
1. Поддержать graceful degradation (очередь/partial response).

## Типичные ошибки

- единый лимит для всех операций;
- отсутствие лимитов на batch endpoint;
- отсутствие observability по дропам `429`;
- retry storm без backoff у клиентов.

## Смежные материалы

- [Безопасность API (OAuth 2.0, JWT, mTLS)](security.md)
- [Паттерны надежности](../integration-methods/reliability-patterns.md)
