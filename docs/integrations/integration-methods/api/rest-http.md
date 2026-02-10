# [REST](../../../glossary.md#abbr-071)/[HTTP](../../../glossary.md#abbr-038)(S)

REST остается базовым стандартом для большинства внешних [API](../../../glossary.md#abbr-005) благодаря простоте и зрелой экосистеме.

## Уровни сложности

### Базовый уровень

- проектировать ресурсные URL и HTTP-методы;
- использовать корректные status codes;
- описывать API через OpenAPI.

### Средний уровень

- внедрять [HATEOAS](../../../glossary.md#abbr-037), caching, pagination;
- применять [RFC](../../../glossary.md#abbr-072) 7807/9457 error model;
- обеспечивать backward compatibility.

### Продвинутый уровень

- проектировать high-scale REST API с observability;
- управлять политиками кэширования и conditional requests;
- внедрять advanced schema patterns (`oneOf`, `anyOf`).

## Принципы REST

- ресурсная модель (`/orders/{id}`);
- унифицированный интерфейс HTTP;
- stateless взаимодействие;
- self-descriptive messages;
- кешируемость ответов там, где уместно.

## HTTP-методы

| Метод | Семантика | [Идемпотентность](../../../glossary.md#term-029) |
| --- | --- | --- |
| GET | чтение | да |
| POST | создание/команда | нет (без доп. паттернов) |
| PUT | полная замена | да |
| PATCH | частичное обновление | зависит от операции |
| DELETE | удаление | да |

## HATEOAS (пример)

```json
{
  "id": "ord-1001",
  "status": "PAID",
  "_links": {
    "self": { "href": "/orders/ord-1001" },
    "cancel": { "href": "/orders/ord-1001/cancel", "method": "POST" }
  }
}
```

## Ошибки по [RFC](../../../glossary.md#abbr-072) 7807/9457

```json
{
  "type": "https://api.example.com/problems/insufficient-funds",
  "title": "Insufficient funds",
  "status": 409,
  "detail": "Balance is lower than requested amount",
  "instance": "/payments/req-991",
  "traceId": "trc-123"
}
```

## Пагинация

| Подход | Плюсы | Минусы |
| --- | --- | --- |
| Offset/limit | простота | медленнее на больших offset |
| Cursor | стабильность при изменениях данных | сложнее реализация |
| Keyset | высокая производительность | ограничение на сортировку |

## Кэширование

- используйте `Cache-Control` и `ETag`;
- для условных запросов применяйте `If-None-Match`;
- разделяйте публичный и приватный cache policy.

## Типичные ошибки

- RPC-дизайн под видом [REST](../../../glossary.md#abbr-071) (`/getOrderById`);
- непоследовательные статус-коды;
- отсутствие версионирования и deprecation;
- смешение транспортных и бизнес-ошибок.
## Стандарты и источники

- [RFC](../../../glossary.md#abbr-072) 9110 [HTTP](../../../glossary.md#abbr-038) Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- RFC 9457 Problem Details: <https://www.rfc-editor.org/rfc/rfc9457>
- Richardson Maturity Model: <https://martinfowler.com/articles/richardsonMaturityModel.html>
