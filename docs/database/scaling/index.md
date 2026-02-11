# Масштабирование БД

Масштабирование БД включает не только рост ресурсов, но и изменение архитектуры хранения, маршрутизации запросов и операционных процессов.

## Уровни сложности

### Базовый

- vertical vs horizontal scaling;
- replication для read scaling.

### Средний

- партиционирование и шардирование;
- shared-nothing vs shared-disk компромиссы.

### Продвинутый

- autoscaling/serverless подходы;
- rebalancing без downtime и migration at scale.

## Базовые стратегии

| Стратегия | Плюсы | Минусы | Когда подходит |
| --- | --- | --- | --- |
| Vertical scaling | просто внедрять | физический потолок и стоимость | ранний этап, умеренный рост |
| Horizontal scaling | устойчивый рост throughput | выше сложность консистентности | high-load и multi-region |
| Logical sharding | контроль доменных границ | нужна дисциплина routing | multi-tenant продукты |
| Serverless DB | эластичность по нагрузке | ограничения по контролю/стоимости | переменная нагрузка |

## Middleware для масштабирования

| Инструмент | Где применяют | Что дает | Ограничения |
| --- | --- | --- | --- |
| Citus | PostgreSQL | distributed tables, parallel query, scale-out | требует дисциплины по distribution key |
| Vitess | MySQL | шардирование, routing, failover tooling | сложнее операционный контур |
| ProxySQL | MySQL | read/write split, routing, pooling | не заменяет шард-архитектуру |

Практика: middleware должен быть частью архитектуры с явным SLA и runbook, а не «скрытым прокси».

## Архитектурная схема

```kroki-plantuml
@startuml
left to right direction
rectangle "App services" as APP
rectangle "Router / Proxy" as PROXY
database "Shard A" as A
database "Shard B" as B
database "Read replica" as R

APP --> PROXY
PROXY --> A : write/read
PROXY --> B : write/read
PROXY --> R : read-heavy
@enduml
```

## Shared-nothing vs Shared-disk

| Модель | Плюсы | Ограничения |
| --- | --- | --- |
| Shared-nothing | лучшая горизонтальная масштабируемость | сложнее cross-shard операции |
| Shared-disk | проще консистентность между узлами | ограничение по storage/interconnect |

## Autoscaling и serverless: практический профиль

| Подход | Когда применять | Риск |
| --- | --- | --- |
| Metric-based autoscaling | предсказуемые пики, есть observability | запаздывание scale-up при резком росте |
| Scheduled scaling | регулярные бизнес-пики (распродажи, отчеты) | перерасход при неверном расписании |
| Fully serverless | нестабильная нагрузка и короткие burst | холодный старт и сложный cost control |

Ключевые метрики для автоскейлинга:

- p95 latency;
- queue depth/connection saturation;
- CPU + disk IO + lock wait;
- cost per 1k transactions.

## Типовые ошибки

- поздний переход к scale-out без миграционного плана;
- отсутствие observability на уровне shard/partition;
- неучтенный рост фоновых операций (vacuum/compaction/rebalance).

## Практические рекомендации

1. Планируйте capacity минимум на 2 горизонта роста вперед.
2. Делайте benchmark на p95/p99, а не только среднее.
3. Автоматизируйте rebalancing и прогоняйте DR drills.
4. Разделяйте [OLTP](../../glossary.md#abbr-060) и [OLAP](../../glossary.md#abbr-059) контуры до масштабного роста.
## Стандарты и источники

- Citus docs: <https://docs.citusdata.com/>
- Vitess docs: <https://vitess.io/docs/>
- ProxySQL docs: <https://proxysql.com/documentation/>

## Переход к подразделам

- [Партицирование](partitioning.md)
- [Шардирование](sharding.md)
