# Колоночные базы данных (Wide-Column)

Wide-column БД ориентированы на масштабируемую запись и чтение по ключу партиции. В них данные организованы по семействам колонок, что удобно для больших распределенных нагрузок.

## Примеры систем

- Apache Cassandra
- ScyllaDB
- Apache HBase
- Google Bigtable

## Пример схемы и запроса (Cassandra CQL)

```sql
CREATE TABLE telemetry (
  device_id text,
  day date,
  ts timestamp,
  metric text,
  value double,
  PRIMARY KEY ((device_id, day), ts, metric)
) WITH CLUSTERING ORDER BY (ts DESC);

SELECT ts, metric, value
FROM telemetry
WHERE device_id = 'dev-101' AND day = '2026-02-09'
LIMIT 100;
```

## Достоинства

- линейное масштабирование на записи;
- высокая отказоустойчивость и распределенность;
- предсказуемая производительность при правильном partition key;
- подходит для high-ingest workloads.

## Недостатки

- моделирование под конкретные запросы (query-driven), меньше гибкости ad-hoc;
- ограниченные join-операции;
- сложность изменения модели после запуска;
- риск hot partitions при плохом ключе.

## Области применения

- телеметрия и лог-события;
- event sourcing хранилища;
- профили с большим объемом событий;
- IoT и industrial monitoring.

## Практические рекомендации

- начинать с проектирования partition key и clustering key;
- ограничивать размер партиций;
- денормализовать осознанно под важные запросы;
- тестировать запросы на реальном объеме до production.

## Смежные материалы

- [Базы данных временных рядов](time-series.md)
- [Шардирование](../../scaling/sharding.md)
