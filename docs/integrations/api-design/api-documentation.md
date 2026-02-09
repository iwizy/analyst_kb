# Документирование API (OpenAPI, RAML)

Документация API это исполнимый контракт, который используется разработкой, QA, интеграторами и платформенной командой.

## Что обязательно документировать

- purpose и domain boundary;
- операции и схемы;
- ошибки и retry semantics;
- auth, scopes, limits;
- версионирование и политика депрекации;
- примеры запросов и ответов.

## OpenAPI

OpenAPI де-факто стандарт описания REST API.

Минимальный пример:

```yaml
openapi: 3.0.3
info:
  title: Orders API
  version: 1.0.0
paths:
  /v1/orders/{orderId}:
    get:
      summary: Get order
      parameters:
        - name: orderId
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: object
                properties:
                  order_id:
                    type: string
                  status:
                    type: string
```

## RAML

RAML используется как альтернативный DSL для API-дизайна.

Минимальный пример:

```yaml
#%RAML 1.0
title: Orders API
version: v1
baseUri: https://api.example.com
/orders/{orderId}:
  get:
    responses:
      200:
        body:
          application/json:
            type: object
            properties:
              order_id: string
              status: string
```

## Рекомендации по процессу

- хранить спецификации в git вместе с кодом;
- использовать contract review как обязательный gate;
- генерировать docs/SDK/mock из спецификации;
- валидировать breaking changes автоматически в CI.

## Инструменты

- OpenAPI: Swagger Editor, Redoc, Stoplight, Spectral.
- RAML: API Designer, AMF tools.

## Частые ошибки

- документация не совпадает с фактической реализацией;
- нет примеров ошибок и limit-политик;
- отсутствует changelog по версиям;
- не описаны SLA и idempotency semantics.

## Смежные материалы

- [Версионирование API](versioning.md)
- [Обратная совместимость](backward-compatibility.md)
