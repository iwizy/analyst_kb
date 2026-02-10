# Реляционные базы данных

Реляционные СУБД остаются базовым выбором для критичных транзакционных систем: финансы, заказы, учет, регуляторные контуры.

## Уровни сложности

### Базовый

- таблицы, ключи, ограничения, ACID;
- базовые CRUD и SQL-запросы.

### Средний

- уровни изоляции, блокировки, индексы, планы выполнения;
- проектирование схемы под бизнес-домен.

### Продвинутый

- partitioning, online-migrations, CI/CD базы, observability, backup/restore drills.

## Где реляционные СУБД подходят лучше всего

| Сценарий | Почему реляционная модель |
| --- | --- |
| Платежи и финансы | строгие инварианты и транзакции |
| Заказы и склад | сложные связи и отчетность SQL |
| Госсектор и комплаенс | аудитируемость и предсказуемость схемы |

## Уровни изоляции транзакций

| Уровень | Что предотвращает | Риск |
| --- | --- | --- |
| Read Uncommitted | почти ничего | dirty reads |
| Read Committed | dirty reads | non-repeatable reads |
| Repeatable Read | non-repeatable reads | phantom reads (зависит от СУБД) |
| Serializable | аномалии чтения/записи | выше latency и риск конфликтов |

## MVCC и блокировки

| Механизм | Принцип | Плюсы | Минусы |
| --- | --- | --- | --- |
| MVCC | версии строк для конкурентных чтений | меньше блокировок read/write | рост version bloat, нужен VACUUM |
| Row-level locks | явная блокировка строк | строгий контроль конфликтов | дедлоки при плохом порядке операций |

## Пример схемы: e-commerce заказ

```sql
CREATE TABLE customers (
  customer_id BIGSERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE orders (
  order_id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT NOT NULL REFERENCES customers(customer_id),
  status TEXT NOT NULL,
  total_amount NUMERIC(14,2) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE order_items (
  order_id BIGINT NOT NULL REFERENCES orders(order_id),
  line_no INT NOT NULL,
  sku TEXT NOT NULL,
  qty INT NOT NULL,
  price NUMERIC(14,2) NOT NULL,
  PRIMARY KEY (order_id, line_no)
);
```

## Индексация и partitioning

```sql
CREATE INDEX idx_orders_customer_created
  ON orders (customer_id, created_at DESC);

CREATE INDEX idx_orders_status
  ON orders (status);
```

Практика partitioning:

- для таблиц событий/заказов с большим объемом использовать range partition по дате;
- хранить retention policy и автоматическое удаление старых разделов;
- проверять, что ключ фильтра попадает в partition pruning.

## Оптимизация запросов и мониторинг

### EXPLAIN-практика

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.order_id, o.total_amount
FROM orders o
WHERE o.customer_id = 10042
ORDER BY o.created_at DESC
LIMIT 20;
```

Контрольные метрики:

- shared/local buffer hits;
- seq scan по крупным таблицам;
- expensive query fingerprints из `pg_stat_statements`.

## Миграции схемы и CI/CD для БД

Рекомендуемый процесс:

1. Миграции в versioned scripts (`V2026_02_10__add_index.sql`).
2. Автоматический прогон в CI на staging-подобных данных.
3. Backward-compatible изменения перед cutover.
4. Roll-forward стратегия, а не `manual hotfix`.

Инструменты:

- Flyway, Liquibase, Sqitch;
- миграционные пайплайны в GitHub Actions/GitLab CI;
- проверка drift схемы перед релизом.

## Backup и восстановление

- ежедневный full backup + WAL/binlog archive;
- регулярный restore-тест в отдельный контур;
- явные цели `RPO` и `RTO` по системам.

## Типовые ошибки

- слишком ранняя денормализация без измерений;
- missing indexes на внешних ключах и частых фильтрах;
- длинные транзакции, блокирующие OLTP;
- миграции без теста rollback/roll-forward.

## Практические рекомендации

1. Держите модель данных близко к доменному языку.
2. Каждое ограничение (`UNIQUE`, `FK`, `CHECK`) должно отражать бизнес-правило.
3. Измеряйте эффект индексов через `EXPLAIN ANALYZE`, а не по интуиции.
4. Делайте квартальные restore drills.

## Контрольные вопросы

1. Какие таблицы и запросы являются bottleneck в текущем SLA?
2. Какие аномалии транзакций критичны для вашего домена?
3. Какие миграции должны быть online-only?
4. Есть ли подтвержденный plan восстановления по RPO/RTO?

## Чек-лист самопроверки

- схема покрывает ключевые инварианты домена;
- определены уровни изоляции для критичных транзакций;
- индексная стратегия основана на реальных query patterns;
- настроены мониторинг и slow query контроль;
- миграции и backup/restore встроены в CI/CD.

## Стандарты и источники

- PostgreSQL docs: <https://www.postgresql.org/docs/>
- MySQL docs: <https://dev.mysql.com/doc/>
- ISO/IEC 9075 SQL: <https://www.iso.org/standard/76583.html>
- Transaction isolation (PostgreSQL): <https://www.postgresql.org/docs/current/transaction-iso.html>
- pg_stat_statements: <https://www.postgresql.org/docs/current/pgstatstatements.html>
