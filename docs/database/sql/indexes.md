# Индексы

Индексы ускоряют чтение, но увеличивают стоимость записи и обслуживания. Проектируйте их под реальные запросы.

## Уровни сложности

### Базовый уровень

- B-Tree для равенства/диапазонов;
- понимание selective columns.

### Средний уровень

- compound, partial и covering indexes;
- GIN/GiST/BRIN под специальные сценарии.

### Продвинутый уровень

- bloat management, reindex strategy;
- контроль write amplification и index debt.

## Примеры

```sql
CREATE INDEX idx_orders_customer_created
  ON orders (customer_id, created_at DESC);

CREATE INDEX idx_orders_paid_recent
  ON orders (created_at DESC)
  WHERE status = 'PAID';
```

## Проверка через EXPLAIN

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT order_id
FROM orders
WHERE customer_id = 10042
ORDER BY created_at DESC
LIMIT 20;
```

## Типовые ошибки

- индексы без привязки к query patterns;
- отсутствие индексов для FK/join полей;
- накопление unused индексов;
- отсутствие мониторинга bloat.

## Практические рекомендации

1. Ведите каталог индексов с обоснованием.
2. Регулярно анализируйте unused/bloat метрики.
3. Удаляйте индексный мусор после периода наблюдения.
4. Проверяйте влияние индексов на write [SLA](../../glossary.md#abbr-079).

## Упражнения

1. Подберите индекс под три критичных [API](../../glossary.md#abbr-005) запроса.
2. Сравните план до/после partial index.
3. Найдите кандидатов на удаление unused index.
## Стандарты и источники

- PostgreSQL indexes: <https://www.postgresql.org/docs/current/indexes.html>
- MySQL indexes: <https://dev.mysql.com/doc/refman/en/mysql-indexes.html>
