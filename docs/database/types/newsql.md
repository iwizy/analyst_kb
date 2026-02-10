# NewSQL базы данных
> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)



NewSQL сочетает SQL-модель и ACID-транзакции с горизонтальным масштабированием распределенных систем.

## Уровни сложности

### Базовый

- понимать, почему NewSQL появился как ответ на ограничения классического scale-up;
- различать distributed SQL и HTAP.

### Средний

- разбираться в 2PC, consensus, quorum и multi-region репликации;
- проектировать первичные ключи и партиционирование для снижения latency.

### Продвинутый

- настраивать кластер, failover и disaster recovery;
- управлять компромиссами CAP/PACELC и стоимостью межрегионального трафика.

## Архитектурные принципы

- shared-nothing кластеры с автоматическим распределением данных;
- consensus-протоколы (Raft/Paxos) для согласованности реплик;
- распределенные транзакции (2PC поверх consensus);
- SQL planner с awareness шардов/партиций.

## CAP/PACELC для NewSQL

| Профиль | Характеристика |
| --- | --- |
| CAP | чаще CP: консистентность при partition важнее полной доступности |
| PACELC | при отсутствии partition компромисс между latency и consistency |

Практика: для критичных доменов финтеха выбирают более строгую консистентность, для глобальных read-сценариев используют локальные read replicas и bounded staleness.

## Сравнение систем

| Система | Ключевые особенности | Ограничения/риски | Типовые сценарии |
| --- | --- | --- | --- |
| Google Spanner | глобальная консистентность, TrueTime, managed service | зависимость от cloud-платформы и стоимости | глобальные платежи, multi-region core systems |
| CockroachDB | PostgreSQL-совместимый distributed SQL, strong consistency | чувствителен к дизайну ключей и hot ranges | SaaS multi-tenant, geo-distributed apps |
| YugabyteDB | совместимость с PostgreSQL API, распределенные транзакции | сложность эксплуатационного тюнинга | high-availability OLTP, гибрид cloud/on-prem |

## Пример ключевого анти-паттерна

- монотонно возрастающий PK (например, `BIGSERIAL`) в write-heavy таблице в distributed SQL может создавать hot shard.

Решения:

- hash/salted keys;
- composite key с tenant/distribution prefix;
- явная таблица партиций по региону/домену.

## Схема multi-region кластера

```kroki-plantuml
@startuml
left to right direction
node "Region A" as A {
  database "Node A1" as A1
  database "Node A2" as A2
}
node "Region B" as B {
  database "Node B1" as B1
  database "Node B2" as B2
}
node "Region C" as C {
  database "Node C1" as C1
}

A1 -- B1 : consensus quorum
A2 -- C1 : replication
B2 -- C1 : replication
@enduml
```

## Best practices

1. Проектируйте key-space под равномерное распределение write-нагрузки.
2. Разделяйте latency-critical и consistency-critical запросы.
3. Закладывайте network RTT между регионами в SLA транзакций.
4. Тестируйте failover/switchover и split-brain сценарии.
5. Держите явный runbook rebalancing и capacity expansion.

## Типовые ошибки

- перенос monolith SQL-схемы без учета распределенности;
- недооценка cross-region latency;
- отсутствие мониторинга replica lag и quorum health;
- неопределенная стратегия DDL-изменений на кластере.
## Стандарты и источники

- Spanner paper: <https://research.google/pubs/pub39966/>
- Spanner docs: <https://cloud.google.com/spanner/docs>
- CockroachDB docs: <https://www.cockroachlabs.com/docs/>
- YugabyteDB docs: <https://docs.yugabyte.com/>
- PACELC paper: <https://ieeexplore.ieee.org/document/6133253>
