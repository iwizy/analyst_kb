# Версионирование API

Версионирование нужно для безопасного развития API без остановки существующих интеграций.

## Подходы

- URL versioning: `/v1/orders`.
- Header versioning: `X-API-Version: 1`.
- Media type versioning: `application/vnd.company.orders.v1+json`.

На практике чаще применяют URL versioning для внешних API и semver-контроль схем для внутренних.

## Политика изменений

### Non-breaking

- добавление нового опционального поля;
- добавление нового endpoint;
- расширение enum с fallback-поведением.

### Breaking

- удаление поля/endpoint;
- изменение типа поля;
- изменение обязательности (`optional -> required`).

## Recommended lifecycle

1. Announce: публикация RFC/changelog.
1. Deprecate: флаг депрекации + дедлайн.
1. Sunset: отключение после миграционного окна.

## Заголовки

- `Deprecation: true`
- `Sunset: Wed, 31 Dec 2026 23:59:59 GMT`

## Пример

```http
GET /v1/orders/ORD-1
Deprecation: true
Sunset: Wed, 31 Dec 2026 23:59:59 GMT
Link: </v2/orders/ORD-1>; rel="successor-version"
```

## Практические рекомендации

- фиксировать compatibility SLA (например, поддержка версии минимум 12 месяцев);
- вести migration guide по каждой major-версии;
- автоматизировать diff-сравнение API-спек;
- не смешивать feature flags и versioning.

## Смежные материалы

- [Обратная совместимость](backward-compatibility.md)
- [Документирование API (OpenAPI, RAML)](api-documentation.md)
