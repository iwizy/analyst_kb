# Поисковые базы данных

Поисковые БД используют inverted index и relevance ranking для быстрого полнотекстового поиска и фильтрации по большим массивам документов.

## Примеры систем

- Elasticsearch
- OpenSearch
- Apache Solr
- Meilisearch

## Пример документа и запроса (Elasticsearch)

### Индексируемый документ

```json
{
  "id": "A-102",
  "title": "Как выбрать базу данных для интернет-магазина",
  "body": "Сравнение PostgreSQL, MongoDB, Elasticsearch",
  "tags": ["database", "architecture"],
  "published_at": "2026-02-09"
}
```

### Поисковый запрос

```json
{
  "query": {
    "bool": {
      "must": [{"match": {"body": "postgresql mongodb"}}],
      "filter": [{"term": {"tags": "database"}}]
    }
  },
  "highlight": {
    "fields": {"body": {}}
  }
}
```

## Достоинства

- быстрый полнотекстовый поиск;
- релевантность, stemming, fuzzy matching, ranking;
- мощные агрегации и faceted navigation;
- удобный инструмент для log analytics.

## Недостатки

- eventual consistency между source DB и поисковым индексом;
- дополнительный operational контур (индексация, reindex);
- не замена транзакционной БД для бизнес-критичных записей.

## Области применения

- поиск по каталогу и контенту;
- enterprise search;
- наблюдаемость и анализ логов;
- поиск по документам и knowledge-base.

## Практические рекомендации

- использовать search engine как read-model, а не source of truth;
- проектировать mapping и analyzers до массовой индексации;
- закладывать процессы backfill/reindex;
- измерять качество поиска: precision, recall, CTR.

## Смежные материалы

- [Документо-ориентированные базы данных](document.md)
- [DWH и Data Lake](../../dwh-and-data-lake.md)
