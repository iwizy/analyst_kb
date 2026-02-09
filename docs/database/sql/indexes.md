# Индексы

Индекс это структура данных, которая ускоряет чтение за счет дополнительного хранилища и затрат на запись. Выбор индекса должен идти от реальных запросов, а не от "общих правил".

## Цель

- уменьшить latency запросов;
- снизить нагрузку на CPU и IO;
- стабилизировать планы выполнения.

## Типы индексов (практически)

- B-tree: равенство, диапазон, сортировка, префиксные условия.
- Hash: точечное равенство (зависит от СУБД).
- GIN/GiST: JSON/arrays/full-text/геоданные (PostgreSQL).
- Full-text: полнотекстовый поиск.
- Composite: несколько колонок в одном индексе.

## Как выбирать индекс

1. Собрать top-N медленных запросов.
1. Проверить `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`.
1. Создать индекс под самый частый паттерн фильтрации.
1. Перепроверить план и фактическое время (`EXPLAIN ANALYZE`).
1. Оценить влияние на INSERT/UPDATE/DELETE.

## Пример

```sql
SELECT order_id, created_at, amount
FROM orders
WHERE customer_id = 932
  AND created_at >= now() - interval '30 days'
ORDER BY created_at DESC
LIMIT 100;

CREATE INDEX idx_orders_customer_created
ON orders (customer_id, created_at DESC);
```

## Оптимизация запросов через индексы

- сначала фильтр, затем сортировка: порядок колонок в composite index важен;
- покрывающие индексы уменьшают обращения к таблице;
- частичные индексы эффективны для горячих подмножеств;
- удаляйте неиспользуемые и дублирующие индексы.

## Частичные и функциональные индексы

```sql
CREATE INDEX idx_orders_paid_recent
ON orders (created_at DESC)
WHERE status = 'paid';

CREATE INDEX idx_users_lower_email
ON users ((lower(email)));
```

## Антипаттерны

- индекс на каждую колонку "на всякий случай";
- неверный порядок колонок в composite index;
- ожидание, что индекс ускорит `LIKE '%text%'` без full-text;
- игнорирование статистики и vacuum/analyze.

## Чек-лист перед продом

- есть baseline latency до и после;
- план запроса использует нужный индекс;
- write overhead приемлем для SLA;
- есть мониторинг bloat и эффективности индексов.

## Смежные материалы

- [Селекты](selects.md)
- [Группировка и сортировка](grouping-sorting.md)
- [Проектирование модели данных](../data-modeling.md)
