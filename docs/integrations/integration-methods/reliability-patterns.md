# Паттерны надежности

Паттерны надежности позволяют выдерживать сбои downstream-сервисов без каскадных отказов всей системы.

## Уровни сложности

### Базовый уровень

- использовать retry, timeout и DLQ;
- настраивать базовые пороги и лимиты;
- исключать бесконечные повторы.

### Средний уровень

- применять circuit breaker и bulkhead;
- комбинировать паттерны по типам операций;
- связывать надежность с observability и error budgets.

### Продвинутый уровень

- внедрять policy-as-code и adaptive resilience;
- настраивать шаблоны per dependency/class of traffic;
- управлять надежностью в multi-region системах.

## Каталог паттернов

| Паттерн | Назначение | Ключевые параметры |
| --- | --- | --- |
| Retry | повтор на transient error | maxAttempts, backoff, jitter |
| Timeout | ограничение ожидания | timeoutMs |
| Circuit Breaker | отсечение неработающего downstream | failureThreshold, openDuration |
| Bulkhead | изоляция ресурсов | pool size, queue size |
| Rate Limit | защита от перегрузки | requests/s, burst |
| DLQ | изоляция невалидных/проблемных сообщений | retention, retry policy |
| Outbox/Inbox | надежная доставка между БД и шиной | poll interval, dedup window |
| Cache-aside | снижение нагрузки на downstream | ttl, stale policy |
| Fallback | деградация без полного отказа | fallback response strategy |

## Комбинирование паттернов

```kroki-plantuml
@startuml
start
:Call downstream;
:Apply timeout;
if (timeout or error?) then (yes)
  :Retry with backoff and jitter;
  if (still failing?) then (yes)
    :Open circuit breaker;
    :Return fallback;
  else (no)
    :Success;
  endif
else (no)
  :Success;
endif
stop
@enduml
```

## Пример конфигурации Resilience4j (концептуально)

```yaml
resilience4j:
  circuitbreaker:
    instances:
      payments:
        slidingWindowSize: 50
        failureRateThreshold: 50
        waitDurationInOpenState: 30s
  retry:
    instances:
      payments:
        maxAttempts: 3
        waitDuration: 200ms
```

## Пример Polly (.NET, псевдо)

```csharp
var retry = Policy.Handle<Exception>()
  .WaitAndRetryAsync(3, i => TimeSpan.FromMilliseconds(100 * i));

var breaker = Policy.Handle<Exception>()
  .CircuitBreakerAsync(5, TimeSpan.FromSeconds(30));

await Policy.WrapAsync(retry, breaker).ExecuteAsync(CallApi);
```

## Метрики observability

| Метрика | Для чего |
| --- | --- |
| retry success rate | эффективность повторов |
| breaker open time | длительность деградации |
| timeout ratio | сигнал перегрузки/сети |
| DLQ backlog age | накопление необработанных сообщений |
| error budget burn rate | скорость "сжигания" SLO бюджета |

## Типичные ошибки

- retry без timeout и ограничений;
- одинаковая политика для read/write операций;
- retry на 4xx ошибки, где повтор бессмыслен;
- отсутствие алертов по breaker и DLQ.
## Стандарты и источники

- Resilience4j docs: <https://resilience4j.readme.io/>
- Polly docs: <https://www.pollydocs.org/>
- Google SRE workbook (error budgets): <https://sre.google/workbook/table-of-contents/>
