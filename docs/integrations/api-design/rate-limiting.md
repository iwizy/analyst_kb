# Лимиты и квоты

Лимиты и квоты защищают [API](../../glossary.md#abbr-005) от перегрузки и обеспечивают справедливое распределение ресурсов между клиентами.

## Уровни сложности

### Базовый уровень

- понимать разницу rate limit и quota;
- возвращать корректные ответы при превышении лимита;
- применять базовый алгоритм token bucket.

### Средний уровень

- проектировать лимиты по клиентам, операциям и тарифам;
- внедрять adaptive throttling;
- согласовывать лимиты с retry и idempotency.

### Продвинутый уровень

- внедрять multi-dimensional quotas и billing triggers;
- управлять глобальными лимитами в multi-region;
- строить прогнозирование нагрузки и auto-tuning лимитов.

## Базовые понятия

| Термин | Значение |
| --- | --- |
| Rate limit | максимальное число запросов в интервале времени |
| Quota | общий бюджет операций за период (день/месяц) |
| Burst | кратковременный всплеск выше базового rps |
| Adaptive throttling | динамическая регулировка лимита по состоянию системы |

## Алгоритмы

| [Алгоритм](../../glossary.md#term-004) | Плюсы | Минусы | Когда применять |
| --- | --- | --- | --- |
| Fixed window | простота | скачки на границе окна | низкая критичность |
| Sliding window | точнее и ровнее | выше вычислительная стоимость | публичные API |
| Token bucket | поддержка burst | нужен корректный refill | высоконагруженные API |
| Leaky bucket | сглаживание нагрузки | менее гибкий для burst | backend с ограниченной емкостью |

## Методика расчета лимитов

1. Сегментируйте клиентов: internal, partner, public, premium.
2. Для операции задайте cost units (дешевые/дорогие методы).
3. Рассчитайте базовый лимит по [SLA](../../glossary.md#abbr-079) и capacity.
4. Добавьте burst allowance и аварийный guardrail.
5. Установите квоту на период и правила replenishment.

### Пример матрицы лимитов

| Клиент | Операция | Лимит в минуту | Burst | Месячная квота |
| --- | --- | --- | --- | --- |
| Public free | GET catalog | 120 | 30 | 200000 |
| Public free | POST order | 20 | 5 | 20000 |
| Partner gold | GET catalog | 1200 | 300 | 3000000 |
| Internal service | POST payment | 600 | 120 | без месячной квоты |

## [HTTP](../../glossary.md#abbr-038)-контракт при превышении

```http
HTTP/1.1 429 Too Many Requests
Retry-After: 30
X-RateLimit-Limit: 120
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1710001000
Content-Type: application/problem+json
```

## Пример конфигурации (Kong, концептуально)

```yaml
plugins:
  - name: rate-limiting
    config:
      minute: 120
      policy: redis
      fault_tolerant: true
```

## Retry с backoff и jitter

- для `429` используйте exponential backoff + jitter;
- ограничьте `max attempts`, чтобы не создать retry storm;
- не повторяйте non-idempotent операции без idempotency key.

## Типичные ошибки

- одинаковый лимит для всех клиентов и операций;
- отсутствие лимитов на "дорогие" endpoints;
- нет telemetry: не видно, кто и где исчерпывает бюджет;
- отсутствие коммуникации лимитов в документации.

## Смежные материалы

- [Идемпотентность](idempotency.md)
- [Обработка ошибок API](error-handling.md)
- [API Gateway и Service Mesh](api-gateway-and-service-mesh.md)
## Стандарты и источники

- [RFC](../../glossary.md#abbr-072) 6585 (429 Too Many Requests): <https://www.rfc-editor.org/rfc/rfc6585>
- RFC 9110 [HTTP](../../glossary.md#abbr-038) Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- Envoy rate limiting: <https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/other_features/global_rate_limiting>
- Kong docs: <https://docs.konghq.com/>
