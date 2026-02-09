# NewSQL базы данных

NewSQL сочетает SQL-интерфейс и транзакционность реляционных систем с горизонтальной масштабируемостью распределенных NoSQL-подходов.

## Когда выбирать

- нужна ACID-транзакционность на кластере из множества узлов;
- требуется SQL-совместимость и привычный инструментарий;
- система быстро растет по данным и нагрузке;
- single-node RDBMS стала узким местом по записи/доступности.

## Примеры систем

- Google Spanner
- CockroachDB
- TiDB
- YugabyteDB
- SingleStore (для mixed workload)

## Пример SQL-запросов

```sql
CREATE TABLE account (
  account_id UUID PRIMARY KEY,
  balance NUMERIC(14,2) NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

BEGIN;
UPDATE account SET balance = balance - 100 WHERE account_id = '11111111-1111-1111-1111-111111111111';
UPDATE account SET balance = balance + 100 WHERE account_id = '22222222-2222-2222-2222-222222222222';
COMMIT;
```

## Достоинства

- горизонтальный scale-out без отказа от SQL;
- высокая доступность через мультиузловую архитектуру;
- автоматический failover и репликация;
- strong consistency в ряде реализаций.

## Недостатки

- операционная сложность выше, чем у single-node RDBMS;
- latency может расти из-за межузловой координации;
- не все фичи классического SQL поддерживаются одинаково;
- стоимость инфраструктуры и SRE-поддержки выше.

## Области применения

- глобальные transactional SaaS-платформы;
- финансовые и учетные системы с geo-distribution;
- высоконагруженные B2B-сервисы, где нужен SQL + масштаб.

## Практические рекомендации

- закладывать latency budget на cross-region консенсус;
- проектировать ключи, избегая hot-spot partition;
- заранее проверять совместимость SQL-диалекта и транзакционной семантики;
- тестировать failure scenarios (node down, network partition).

## Смежные материалы

- [Реляционные базы данных](relational.md)
- [Консистентность и распределение](../consistency-and-distribution.md)
- [Шардирование](../scaling/sharding.md)
