# Базы данных временных рядов

Time-series БД (TSDB) оптимизированы для данных с временной меткой: быстрый ingest, агрегации по окнам времени, retention policy и downsampling.

## Примеры систем

- InfluxDB
- TimescaleDB
- Prometheus
- VictoriaMetrics
- OpenTSDB

## Пример записи и запроса

### Influx line protocol

```text
cpu_usage,host=app-1,env=prod value=0.73 1765273500000000000
```

### SQL-подобный запрос (TimescaleDB)

```sql
SELECT time_bucket('5 minutes', ts) AS bucket,
       AVG(value) AS avg_cpu
FROM metrics
WHERE metric = 'cpu_usage'
  AND ts >= now() - interval '1 hour'
GROUP BY bucket
ORDER BY bucket;
```

## Достоинства

- высокая скорость записи time-stamped данных;
- встроенные функции агрегации, retention и compression;
- эффективные запросы по временным окнам;
- удобство для мониторинга и наблюдаемости.

## Недостатки

- не лучшая модель для сложных relational-join задач;
- при неверной политике retention быстро растет storage;
- требуется продуманная cardinality тегов.

## Области применения

- метрики инфраструктуры и приложений;
- IoT сенсоры;
- финансовые временные ряды;
- производственная телеметрия.

## Практические рекомендации

- заранее определить retention tiers (hot/warm/cold);
- ограничивать высокую cardinality тегов;
- применять downsampling для долгого хранения;
- проектировать алерты на агрегатах, а не на сырых точках.

## Смежные материалы

- [Колоночные базы данных](columnar.md)
- [DWH и Data Lake](../../dwh-and-data-lake.md)
