# Инструменты интеграций

Раздел покрывает инструменты для [ETL](../glossary.md#abbr-033)/[ELT](../glossary.md#abbr-030), событийных платформ, [API](../glossary.md#abbr-005) management, service mesh и observability в распределенных системах.

## Уровни сложности

### Базовый уровень

- выбрать инструмент под паттерн интеграции;
- настроить базовый мониторинг ошибок/задержек;
- понимать где нужен ETL, где streaming, где orchestration.

### Средний уровень

- внедрять schema governance и retry/DLQ стратегии;
- интегрировать брокеры, API gateway и monitoring stack;
- управлять эксплуатационными рисками интеграций.

### Продвинутый уровень

- проектировать платформу интеграций на уровне программы;
- автоматизировать контроль качества и reliability;
- строить end-to-end tracing и [SLA](../glossary.md#abbr-079)/[SLO](../glossary.md#abbr-081) по интеграциям.

## Категории и инструменты

| Категория | Инструменты | Паттерны |
| --- | --- | --- |
| iPaaS | MuleSoft, Boomi, Workato | SaaS/B2B интеграции, orchestration |
| ESB/BPM | WSO2, Camunda | process orchestration, enterprise flows |
| ETL/ELT | Talend, dbt, Airflow, Flink | batch/stream transformation |
| Брокеры и [UI](../glossary.md#abbr-091) | Kafka, RabbitMQ UI, Pulsar Manager | pub/sub, event streaming |
| API management | Kong, Apigee, Azure API Management | auth, rate limit, portal, governance |
| Service mesh observability | Kiali, Linkerd Viz | [mTLS](../glossary.md#abbr-052), traffic policy, service-to-service visibility |
| Observability stack | Prometheus, Grafana, Jaeger, Kibana | metrics, logs, traces |

## Сравнение интеграционных решений

| Инструмент | Коннекторы | Сложность настройки | Лицензия/стоимость | Когда выбирать |
| --- | --- | --- | --- | --- |
| Talend Cloud | много готовых коннекторов | средняя/высокая | commercial | enterprise ETL/ELT |
| dbt | [SQL](../glossary.md#abbr-084)-centric трансформации | средняя | OSS + cloud | аналитические ELT пайплайны |
| Airflow | оркестрация DAG | средняя/высокая | OSS | расписания и зависимые задачи |
| Apache Flink | stream processing | высокая | OSS | real-time вычисления |
| Kafka Connect | коннекторы [CDC](../glossary.md#abbr-014) и sink/source | средняя | OSS/Confluent | потоковые интеграции и CDC |
| NiFi | визуальные data flow | средняя | OSS | быстрое проектирование потоков |

## Практические сценарии

### ETL-пайплайн: Talend vs dbt

- Talend: когда нужен визуальный designer и много heterogeneous источников.
- dbt: когда основной слой трансформаций в [DWH](../glossary.md#abbr-029) SQL-first.

### Kafka Connect + Schema Registry

1. Поднять source connector (например, Debezium для PostgreSQL).
2. Регистрировать схемы в Schema Registry.
3. Настроить совместимость схем (backward/full).
4. Ввести DLQ/retry topics.

```json
{
  "name": "pg-cdc-orders",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "database.hostname": "postgres",
    "database.port": "5432",
    "database.dbname": "core",
    "database.user": "cdc_user",
    "table.include.list": "public.orders",
    "topic.prefix": "core"
  }
}
```

### NiFi vs Airflow

- NiFi: лучше для data flow routing и near-real-time ingestion.
- Airflow: лучше для batch orchestration и dependency-aware расписаний.

### [ETL](../glossary.md#abbr-033) template (dbt model)

```sql
select
  order_id,
  customer_id,
  amount,
  created_at::date as order_date
from {{ ref('stg_orders') }}
where status = 'PAID'
```

## Retry, DLQ и recovery

- retry topics с backoff;
- DLQ для невалидных/необрабатываемых сообщений;
- replay-процедуры с audit trail;
- алерты на retry storms и consumer lag.

## Мониторинг интеграций

| Что мониторить | Пример сигнала |
| --- | --- |
| Задержка | consumer lag, queue depth |
| Ошибки | error rate, failed transformations |
| [Доступность](../glossary.md#term-025) | connector/task status |
| [Производительность](../glossary.md#term-053) | throughput, p95 latency |
| Стабильность | rebalance frequency, retry storm |

Рекомендации:

- алерты по [SLA](../glossary.md#abbr-079)/[SLO](../glossary.md#abbr-081), а не только по инфраструктурным метрикам;
- OpenTelemetry для end-to-end trace;
- correlation id в сообщениях и логах.

## [Интеграция](../glossary.md#term-033) с [API](../glossary.md#abbr-005) gateway и mesh

- синхронные API через gateway;
- асинхронные каналы через broker;
- политики безопасности и лимитов на edge;
- трассировка запросов через mesh + tracing backend.

## [Зависимость](../glossary.md#term-027) от архитектурного стиля

- Микросервисы: обязательны API management, брокеры, tracing и mesh-политики.
- SOA/ESB: важны централизованные mediation/transformation-инструменты.
- Event-driven: критичны schema registry, lag monitoring и replay tooling.

## Связь с требованиями и SDLC

- требования: фиксировать интеграционные контракты и SLA;
- дизайн: выбрать паттерн (sync/async/file/event);
- реализация: настроить connectors, schema governance, retries;
- тестирование: contract + load + chaos сценарии;
- эксплуатация: мониторинг, incident response, [RCA](../glossary.md#abbr-070).

## Кросс-ссылки

- [Интеграции](../integrations/index.md)
- [Паттерны надежности](../integrations/integration-methods/reliability-patterns.md)
- [Процесс разработки: Мониторинг и логирование](../development-process/feature-support/monitoring-logging.md)
- [Требования: Трассировка](../requirements/management/traceability.md)

## Типичные ошибки

- отсутствие ownership у интеграционных контрактов;
- запуск потоков без schema governance;
- DLQ без процесса обработки;
- нет end-to-end мониторинга бизнес-сценария.
## Источники

- MuleSoft: <https://www.mulesoft.com/>
- Boomi: <https://boomi.com/>
- Workato: <https://www.workato.com/>
- Apache Airflow: <https://airflow.apache.org/>
- Apache Flink: <https://flink.apache.org/>
- dbt: <https://docs.getdbt.com/>
- Kafka Connect: <https://kafka.apache.org/documentation/#connect>
- Confluent Schema Registry: <https://docs.confluent.io/platform/current/schema-registry/>
- Kong: <https://docs.konghq.com/>
- Apigee: <https://cloud.google.com/apigee/docs>
- Kiali: <https://kiali.io/>
- OpenTelemetry: <https://opentelemetry.io/docs/>

## Актуализация

- пересматривайте коннекторы и версии брокеров при каждом крупном апгрейде платформы;
- обновляйте alerting-порог и runbook по результатам postmortem.
