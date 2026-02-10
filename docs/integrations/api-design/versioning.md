# Версионирование API

Версионирование нужно для безопасной эволюции API без срыва SLA и внезапных поломок клиентов.

## Уровни сложности

### Базовый уровень

- понимать разницу major/minor/patch;
- применять единый подход к версии API;
- фиксировать breaking/non-breaking изменения.

### Средний уровень

- внедрить deprecation и sunset policy;
- автоматизировать compatibility checks в CI;
- управлять миграциями клиентов через dual-run.

### Продвинутый уровень

- поддерживать многоверсионные API-продукты;
- использовать canary и feature flags для безопасного rollout;
- выстраивать governance по version lifecycle.

## Стратегии версионирования

| Стратегия | Пример | Плюсы | Минусы |
| --- | --- | --- | --- |
| URL versioning | `/v1/orders` | очевидно для клиентов | дублирование маршрутов |
| Header versioning | `X-API-Version: 2` | чистые URL | сложнее дебажить |
| Media type | `application/vnd.payments.v2+json` | гибко для контента | выше сложность поддержки |
| SemVer контракта | `2.3.1` | понятно в CI/CD и каталогах | нужно дисциплинированное управление |

## Что считать breaking-change

- удаление поля, которое использует клиент;
- изменение типа поля (`string` -> `object`);
- изменение обязательности (`optional` -> `required`);
- изменение семантики кода ответа;
- изменение поведения без изменения контракта.

## Политика версий (пример)

| Политика | Публичный API | Внутренний API |
| --- | --- | --- |
| Release cadence | раз в 2 недели minor | по sprint/release train |
| Поддержка major | 2 последних major | 1-2 major по договоренности |
| Deprecation period | минимум 6 месяцев | 1-3 месяца |
| Sunset уведомление | email + portal + changelog | уведомление в engineering channels |

## Процесс миграции клиентов

1. Анонсируйте изменение и migration guide.
2. Запустите canary для части клиентов.
3. Поддерживайте dual-read/dual-write, если нужен перенос данных.
4. Мониторьте ошибки и usage per version.
5. Закройте legacy после sunset date.

## Интеграция с Gateway и Mesh

- в gateway маршрутизируйте по версии и политики доступа;
- в mesh применяйте traffic splitting для canary;
- включайте compatibility тесты в pre-deploy;
- используйте feature flags для постепенного включения поведения.

## Инструменты

- OpenAPI diff (`oasdiff`, `swagger-diff`);
- GraphQL Inspector;
- Redocly/Stoplight для публикации changelog;
- Kong/Apigee/Istio для traffic shaping и deprecation routing.
## Стандарты и источники

- SemVer: <https://semver.org/>
- OpenAPI Spec: <https://spec.openapis.org/oas/latest.html>
- Microsoft API versioning guidelines: <https://learn.microsoft.com/azure/architecture/best-practices/api-design>
- Stripe API versioning (пример практики): <https://docs.stripe.com/api/versioning>
