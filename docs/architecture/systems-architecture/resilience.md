# Отказоустойчивость и надежность

Надежность — это способность системы сохранять бизнес-функции при частичных сбоях и быстро восстанавливаться.

## Уровни сложности

### Базовый уровень

- понимать retry, timeout, circuit breaker;
- проектировать health checks;
- добавлять graceful degradation.

### Средний уровень

- комбинировать resilience-паттерны;
- внедрять canary и blue/green;
- управлять error budget и SLO.

### Продвинутый уровень

- строить multi-region отказоустойчивость;
- внедрять chaos engineering;
- управлять надежностью на уровне платформы.

## Паттерны надежности

| Паттерн | Что решает | Риски неправильной настройки |
| --- | --- | --- |
| Timeout | ограничивает время ожидания | слишком короткий/длинный timeout |
| Retry + backoff + jitter | сглаживает transient ошибки | retry storm |
| Circuit Breaker | защищает от каскадных отказов | неверные пороги |
| Bulkhead | изолирует ресурсы | сложность capacity планирования |
| Rate limiting | защищает систему | ложные отказы без адаптивности |
| Health checks | раннее выявление проблем | noisy probes |
| Graceful degradation | сохраняет core-функционал | неконсистентный UX |
| Canary / Blue-Green | безопасный rollout | сложный rollback |

## Инструменты

- Resilience4j / Polly / (legacy) Hystrix;
- Envoy, Linkerd, Istio policies;
- Kubernetes liveness/readiness/startup probes.

## Эволюция надежности

| Этап | Характеристика |
| --- | --- |
| Single node | минимальная устойчивость, простой ops |
| Cluster | failover внутри региона |
| Multi-region | региональная устойчивость и DR |
| Multi-cloud | максимум устойчивости, высокая сложность |

## Пример SLA уровней

- `99.9%`: один регион + быстрый rollback.
- `99.95%`: multi-AZ и автоматизированный failover.
- `99.99%`: multi-region active/active, строгий runbook.

## Практические рекомендации

1. Сначала определите SLO и error budget.
2. Настройте timeout и retry по dependency-profile.
3. Добавьте graceful degradation для non-critical features.
4. Регулярно проводите game day/chaos проверки.

## Типичные ошибки

- retry без jitter и верхнего лимита;
- отсутствие read/write timeout budgets;
- нет runbook и failover drills;
- отсутствие метрик по breaker/open state.

Кросс-ссылка: [Паттерны надежности в интеграциях](../../integrations/integration-methods/reliability-patterns.md).
## Стандарты и источники

- Google SRE book/workbook.
- Resilience4j docs.
- Kubernetes reliability best practices.
