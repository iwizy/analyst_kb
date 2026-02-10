# Мониторинг и логирование

Наблюдаемость (observability) позволяет понимать состояние системы и принимать решения на основе данных, а не предположений.

## Уровни сложности

### Базовый уровень

- различать метрики, логи и трейсы;
- понимать базовые сигналы: latency, error rate, throughput, saturation;
- строить минимальный набор алертов на критичные пользовательские сценарии.

### Средний уровень

- проектировать дашборды и alert policy;
- использовать correlation ID для диагностики цепочек вызовов;
- согласовывать [SLI](../../glossary.md#abbr-080)/[SLO](../../glossary.md#abbr-081) и пороги эскалации.

### Продвинутый уровень

- настраивать SLO-driven alerting;
- снижать alert fatigue через noise reduction;
- применять distributed tracing для сложных интеграционных цепочек.

## Три кита observability

| Сигнал | Что отвечает | Пример |
| --- | --- | --- |
| Metrics | «Насколько хорошо работает?» | p95 latency, error rate, CPU |
| Logs | «Что именно произошло?» | structured logs с request_id |
| Traces | «Где именно тормозит?» | цепочка сервисов и timing |

## Минимальный поток мониторинга

```kroki-plantuml
skinparam monochrome true
start
:Сервисы публикуют metrics/logs/traces;
:Платформа наблюдаемости агрегирует сигналы;
if (Порог SLO нарушен?) then (Да)
  :Создать алерт;
  :Оповестить on-call;
  :Запустить runbook;
else (Нет)
  :Продолжить наблюдение;
endif
stop
```

## [SLI](../../glossary.md#abbr-080)/[SLO](../../glossary.md#abbr-081)/[SLA](../../glossary.md#abbr-079)

| Термин | Определение | Пример |
| --- | --- | --- |
| SLI | измеримый индикатор качества | успешные ответы [API](../../glossary.md#abbr-005) |
| SLO | целевое значение SLI | 99.9% успешных ответов в 30 дней |
| SLA | внешнее договорное обязательство | штрафы при недоступности |

## Практики, которые работают

- структурированные логи в едином формате;
- correlation ID от edge до БД;
- отдельные алерты на симптомы и первопричины;
- dashboard по пользовательским сценариям, а не только по инфраструктуре;
- регулярный пересмотр порогов и runbook.

## Типовые ошибки

- много «красивых» метрик без операционной пользы;
- алерты без инструкции действий;
- отсутствие связи между incident review и настройкой мониторинга.

## Шаблон runbook для алерта

| Поле | Содержание |
| --- | --- |
| Alert ID | ALRT-PAY-503 |
| [Триггер](../../glossary.md#term-072) | error_rate > 2% 5 минут |
| Проверка | health endpoints, recent deploy, external API status |
| Действия | rollback/circuit breaker/fallback |
| Эскалация | on-call L2 -> architect -> vendor |## Стандарты и источники

- OpenTelemetry: <https://opentelemetry.io/docs/>
- Google SRE workbook (monitoring): <https://sre.google/workbook/>
- Prometheus best practices: <https://prometheus.io/docs/practices/>
