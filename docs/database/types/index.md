# Типы баз данных

Выбор типа БД начинается с нагрузки, консистентности и структуры данных. Нет универсальной "лучшей" СУБД: оптимальный выбор всегда контекстный.

## Краткая карта типов

| Тип | Основная модель | Лучший сценарий | Примеры систем |
| --- | --- | --- | --- |
| Реляционные | таблицы + SQL | OLTP, строгая консистентность, сложные JOIN | PostgreSQL, MySQL, Oracle, SQL Server |
| NoSQL документные | JSON/BSON документы | гибкая схема, каталоги, профили | MongoDB, Couchbase |
| NoSQL key-value | ключ -> значение | кэш, сессии, ultra-low latency | Redis, DynamoDB, Riak |
| NoSQL колоночные | wide-column | high write + горизонтальный масштаб | Cassandra, HBase, ScyllaDB |
| NoSQL временных рядов | метрика + timestamp | мониторинг, IoT, телеметрия | InfluxDB, TimescaleDB, Prometheus |
| NoSQL графовые | узлы и связи | графы отношений, рекомендации, fraud graph | Neo4j, JanusGraph, Neptune |
| NoSQL поисковые | inverted index | полнотекстовый поиск и релевантность | Elasticsearch, OpenSearch, Solr |
| NewSQL | SQL + распределенность | транзакционный scale-out | CockroachDB, TiDB, YugabyteDB, Spanner |
| Распределенные реестры | неизменяемый ledger | multi-party trust, audit trail | Hyperledger Fabric, Corda, Ethereum |

## Визуальная схема выбора

```kroki-plantuml
@startuml
start
:Нужна строгая транзакционность?;
if (Да) then (Да)
  :SQL и сложные JOIN критичны?;
  if (Да) then (Да)
    :Реляционная или NewSQL;
  else (Нет)
    :Оценить специализированные OLTP движки;
  endif
else (Нет)
  :Доминирует конкретный паттерн данных?;
  if (Документы) then (Да)
    :Документо-ориентированная БД;
  elseif (Ключ-значение) then (Да)
    :Key-Value;
  elseif (Временные ряды) then (Да)
    :TSDB;
  elseif (Граф связей) then (Да)
    :Графовая БД;
  elseif (Полнотекстовый поиск) then (Да)
    :Поисковая БД;
  else (Нет)
    :Оценить колоночную/гибридную архитектуру;
  endif
endif
stop
@enduml
```

## Практические правила

- сначала определяйте критичные инварианты данных, потом тип БД;
- разделяйте operational storage и аналитическое хранилище;
- не пытайтесь закрыть все сценарии одной СУБД;
- проектируйте миграционный путь заранее (особенно при росте нагрузки).

## Переход к подразделам

- [Реляционные базы данных](relational.md)
- [NoSQL базы данных](nosql/index.md)
- [NewSQL базы данных](newsql.md)
- [Распределенные реестры](../distributed-ledgers/index.md)
- [Консистентность и распределение](../consistency-and-distribution.md)
