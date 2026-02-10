# Поисковые базы данных

Поисковые движки строят inverted index и обеспечивают полнотекстовый поиск, релевантность и быстрые фасетные фильтры.

## Уровни сложности

### Базовый

- индекс, документ, analyzer;
- базовые запросы `match`, `term`, `range`.

### Средний

- проектирование mapping и relevance;
- стратегия переиндексации без простоя.

### Продвинутый

- CDC-синхронизация с primary DB;
- ILM/lifecycle и cost optimization.

## Где применять

- каталог товаров и контента;
- поиск по логам и инцидентам;
- enterprise knowledge search.

## Пример mapping

```json
{
  "mappings": {
    "properties": {
      "title": { "type": "text" },
      "category": { "type": "keyword" },
      "price": { "type": "double" },
      "createdAt": { "type": "date" }
    }
  }
}
```

## Пример запроса

```json
{
  "query": {
    "bool": {
      "must": [{ "match": { "title": "кофемашина" } }],
      "filter": [
        { "term": { "category": "home_appliances" } },
        { "range": { "price": { "lte": 20000 } } }
      ]
    }
  }
}
```

## Консистентность и целостность

- индекс обычно eventual-consistent относительно primary DB;
- для критичных операций подтверждение делать через primary store;
- использовать outbox/CDC для надежного обновления индекса.

## Безопасность

- RBAC по индексам;
- field/document-level security для чувствительных данных;
- аудит поисковых запросов в regulated контуре.

## Миграция из SQL

1. Выделить search use cases и SLA.
2. Спроектировать индексный документ.
3. Подключить CDC pipeline.
4. Внедрить alias-based reindex без простоя.

## Типовые ошибки

- использовать search как source of truth для транзакций;
- не контролировать ILM и рост storage;
- отсутствие fallback при рассинхронизации индекса.

## Практические рекомендации

1. Разделяйте transactional API и search API.
2. Используйте versioned aliases для безопасных миграций.
3. Мониторьте relevance и latency отдельно.
4. Планируйте lifecycle и архивирование индексов.
## Стандарты и источники

- OpenSearch docs: <https://opensearch.org/docs/latest/>
- Elasticsearch docs: <https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html>
- Apache Lucene: <https://lucene.apache.org/core/>
