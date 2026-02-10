# Шардирование

Шардирование распределяет данные по нескольким независимым узлам, снимая пределы одного сервера и повышая масштабируемость.

## Уровни сложности

### Базовый

- shard key и routing;
- типы шардирования: range/hash/directory.

### Средний

- shard-aware clients;
- middleware routing (Citus, Vitess, ProxySQL).

### Продвинутый

- online rebalancing и data migration;
- logical sharding и hybrid-архитектуры.

## Архитектурные варианты

| Подход | Преимущества | Ограничения |
| --- | --- | --- |
| Client-side sharding | полный контроль приложения | сложнее поддержка и изменения |
| Middleware sharding | централизованный routing | доп. компонент и отказные сценарии |
| Managed sharding | меньше операционной нагрузки | vendor lock-in |

## Middleware примеры

- Citus (PostgreSQL distributed extension);
- Vitess (MySQL sharding layer);
- ProxySQL (routing/pooling/read-write split для MySQL).

## Схема shard-aware routing

```kroki-plantuml
@startuml
left to right direction
rectangle "Service" as S
rectangle "Shard router" as R
database "Shard 1" as D1
database "Shard 2" as D2
database "Shard 3" as D3

S --> R : tenant_id / shard_key
R --> D1
R --> D2
R --> D3
@enduml
```

## Rebalancing и миграции

1. Выявить hot shards и целевое перераспределение.
2. Выполнить incremental copy + dual-write.
3. Провести consistency check по контрольным суммам.
4. Переключить routing и завершить cutover.

## Hybrid-подходы

- logical sharding по tenant/domain;
- shared-nothing для write-heavy контуров;
- shared-disk/replica для аналитических read-path.

## Autoscaling и serverless

- serverless БД подходят для переменной нагрузки;
- важны контроль cold start, cost model и лимиты транзакций;
- для stateful high-throughput систем часто нужен управляемый, но не полностью serverless режим.

## Типовые ошибки

- выбор shard key с высокой вероятностью hot spots;
- cross-shard joins в критичном OLTP пути;
- отсутствие стратегии resharding;
- недооценка operational tooling и observability.

## Практические рекомендации

1. Тестируйте распределение ключей на исторических данных.
2. Ограничьте cross-shard операции и сделайте их асинхронными.
3. Подготовьте план resharding до того, как он понадобится.
4. Мониторьте shard skew, p99 latency и rebalance backlog.
## Стандарты и источники

- Citus docs: <https://docs.citusdata.com/>
- Vitess docs: <https://vitess.io/docs/>
- ProxySQL docs: <https://proxysql.com/documentation/>
