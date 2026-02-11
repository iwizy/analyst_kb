# Транзакции, блокировки и дедлоки

Транзакции и блокировки определяют, как система ведет себя при конкурирующих изменениях. Для аналитика это критично в сценариях платежей, резервов, списаний и любых операций с инвариантами.

## Уровни сложности

### Базовый уровень

- `BEGIN`/`COMMIT`/`ROLLBACK`;
- [ACID](../../glossary.md#abbr-001) и уровни изоляции.

### Средний уровень

- `SELECT ... FOR UPDATE`, optimistic locking;
- диагностика блокировок и ожиданий.

### Продвинутый уровень

- стратегия retry для deadlock/serialization failure;
- проектирование транзакционных границ в распределенной архитектуре.

## Уровни изоляции и аномалии

| Уровень | Что предотвращает | Что может остаться |
| --- | --- | --- |
| Read Committed | dirty read | non-repeatable read, lost update |
| Repeatable Read | non-repeatable read | phantom (зависит от СУБД) |
| Serializable | основные конкурентные аномалии | рост конфликтов и retry |

## Базовый шаблон транзакции

```sql
BEGIN;

UPDATE account
SET balance = balance - 1000
WHERE account_id = 101
  AND balance >= 1000;

UPDATE account
SET balance = balance + 1000
WHERE account_id = 202;

COMMIT;
```

Если первое обновление не затронуло строку, делается `ROLLBACK`.

## Пессимистическая блокировка

```sql
BEGIN;

SELECT balance
FROM account
WHERE account_id = 101
FOR UPDATE;

-- проверка бизнес-условия и обновление

COMMIT;
```

Подходит для коротких критичных операций, где конфликт вероятен и недопустим.

## Оптимистическая блокировка

```sql
UPDATE order_header
SET status = 'PAID',
    version = version + 1
WHERE order_id = 5001
  AND version = 12;
```

Если обновлено `0` строк, запись изменилась конкурентно и требуется повтор чтения.

## Deadlock: типовой сценарий

1. Транзакция A блокирует `order`.
1. Транзакция B блокирует `payment`.
1. A пытается обновить `payment`, B пытается обновить `order`.
1. СУБД прерывает одну транзакцию как deadlock victim.

Как снижать риск:

- единый порядок обновления сущностей;
- короткие транзакции без внешних вызовов внутри;
- повтор операции с backoff для retryable ошибок.

## Retry-политика для транзакций

| Ошибка | Действие |
| --- | --- |
| Deadlock detected | retry с jitter/backoff |
| Serialization failure | retry ограниченное число раз |
| Lock timeout | анализ contention + корректировка запроса |

Практика: ограничивать retries (например, 3 попытки) и логировать конфликтующие ключи.

## PostgreSQL и MySQL: практические различия

| Тема | PostgreSQL | MySQL/InnoDB |
| --- | --- | --- |
| MVCC | по умолчанию, сильная модель snapshot | MVCC в InnoDB |
| Диагностика блокировок | `pg_locks`, `pg_stat_activity` | `performance_schema`, `SHOW ENGINE INNODB STATUS` |
| Serializable | через predicate locking и retry | зависит от паттернов доступа и gap locks |

## Наблюдаемость и контроль

Минимальные метрики:

- lock wait time p95;
- deadlock count;
- tx duration p95/p99;
- rollback rate;
- retry success rate.

## Типовые ошибки

- долгие транзакции с вызовами внешних API;
- read-modify-write без блокировки или version check;
- отсутствие retry для сериализуемых конфликтов;
- попытка решить contention только увеличением ресурсов.

## Практические рекомендации

1. Фиксируйте транзакционные инварианты на этапе требований.
2. Держите транзакции короткими и локальными к БД.
3. Для критичных операций выбирайте явную стратегию конкурентности.
4. Проводите нагрузочное тестирование с конкурентными конфликтами.
## Стандарты и источники

- PostgreSQL transactions: <https://www.postgresql.org/docs/current/tutorial-transactions.html>
- PostgreSQL isolation levels: <https://www.postgresql.org/docs/current/transaction-iso.html>
- MySQL InnoDB locking: <https://dev.mysql.com/doc/refman/en/innodb-locking.html>
- SQL standard (ISO/IEC 9075): <https://www.iso.org/standard/76583.html>
