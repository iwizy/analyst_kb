# Способы интеграции

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Подраздел описывает интеграции по каналам взаимодействия: синхронные API, асинхронные события, брокеры сообщений, файловый обмен и shared data patterns.

## Уровни сложности

### Базовый уровень

- различать request/response, pub/sub и batch file;
- выбирать канал по latency и надежности;
- описывать минимальный контракт и ошибки.

### Средний уровень

- применять Saga, CQRS и outbox;
- сочетать API и события в одном домене;
- проектировать retry, DLQ и idempotency.

### Продвинутый уровень

- строить event-driven платформы с governance;
- управлять зависимостями между десятками сервисов;
- проектировать интеграции для multi-region и compliance.

## Сравнение подходов

| Подход | Latency | Консистентность | Типовые сценарии |
| --- | --- | --- | --- |
| API request/response | низкая | выше, но сильная связность | валидация лимита, checkout |
| Messaging pub/sub | средняя | eventual | уведомления, интеграция доменов |
| Shared database | низкая | высокая локально | legacy/монолитные контуры |
| File exchange | высокая | пакетная | межсистемный регламентный обмен |

## Как выбирать подход

1. Определите критичность операции и бизнес-риски.
2. Уточните latency budget и допустимую задержку.
3. Зафиксируйте требования к консистентности и аудиту.
4. Оцените coupling: кто зависит от кого и как быстро меняется.
5. Выберите паттерн надежности и план деградации.

## Карта подраздела

- [Интеграционные паттерны](patterns.md)
- [Паттерны надежности](reliability-patterns.md)
- [Типы API](api/index.md)
- [Брокеры сообщений](message-brokers/index.md)
- [Общая БД](shared-database.md)
- [Обмен файлами](file-exchange.md)
## Стандарты и источники

- Enterprise Integration Patterns: <https://www.enterpriseintegrationpatterns.com/>
- AsyncAPI: <https://www.asyncapi.com/docs/reference/specification/latest>
- RFC 9110 HTTP Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
