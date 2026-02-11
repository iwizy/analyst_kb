# Базы данных временных рядов

TSDB оптимизированы под потоковые записи и оконный анализ метрик/телеметрии.

## Уровни сложности

### Базовый

- metric, timestamp, tags, fields;
- retention и downsampling.

### Средний

- проектирование tags без cardinality explosion;
- continuous aggregates и [SLO](../../../glossary.md#abbr-081)-метрики.

### Продвинутый

- stream ingestion + TSDB + alerting;
- multi-tenant observability platform.

## Где применять

- мониторинг инфраструктуры и приложений;
- IoT телеметрия;
- операционные [KPI](../../../glossary.md#abbr-047) в near-real-time.

## Пример записи

```text
cpu_usage,host=app-01,region=eu value=72.4 1739187000000000000
```

## Пример запроса

```sql
SELECT time_bucket('5 minutes', ts) AS bucket,
       avg(cpu_usage) AS avg_cpu
FROM infra_metrics
WHERE host = 'app-01' AND ts >= now() - interval '1 day'
GROUP BY bucket
ORDER BY bucket;
```

## [Консистентность](../../../glossary.md#term-040) и целостность

- write path ориентирован на throughput;
- eventual consistency допустима для мониторинга;
- для биллинговых/финансовых метрик нужны reconcile-процедуры.

## Безопасность

- [TLS](../../../glossary.md#abbr-088) и auth агентов;
- контроль [PII](../../../glossary.md#abbr-063) в tags;
- [RBAC](../../../glossary.md#abbr-069) для dashboard/query.

## [Миграция](../../../glossary.md#term-045) из [SQL](../../../glossary.md#abbr-084)

1. Вывести метрики из [OLTP](../../../glossary.md#abbr-060) таблиц.
2. Определить retention слои (raw/rollup/archive).
3. Настроить ingestion и quality checks.
4. Сверить стоимость хранения на горизонте роста.

## Типовые ошибки

- хранить user_id в tags (высокая cardinality);
- отсутствие retention policy;
- отсутствие стандартов именования метрик.

## Практические рекомендации

1. Жестко ограничьте high-cardinality labels.
2. Разделите ingestion и аналитические запросы по [SLA](../../../glossary.md#abbr-079).
3. Введите naming convention и owner для каждой метрики.
4. Мониторьте gaps, lag и loss событий.
## Стандарты и источники

- InfluxDB docs: <https://docs.influxdata.com/>
- Timescale docs: <https://docs.timescale.com/>
- OpenTelemetry metrics: <https://opentelemetry.io/docs/specs/otel/metrics/>
