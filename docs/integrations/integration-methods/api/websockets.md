# WebSockets

WebSockets дают двусторонний канал связи в реальном времени и применяются там, где polling слишком дорогой или медленный.

## Уровни сложности

### Базовый уровень

- понимать handshake и жизненный цикл соединения;
- реализовывать heartbeat и reconnect;
- разграничивать каналы/топики по подписке.

### Средний уровень

- использовать протоколы поверх WebSocket (STOMP, MQTT, Socket.IO);
- внедрять backpressure и rate control;
- проектировать отказоустойчивый reconnect.

### Продвинутый уровень

- масштабировать миллионы соединений через sharding;
- сочетать WebSockets с message brokers;
- проектировать fallback на SSE/long polling.

## Базовый поток

```kroki-plantuml
@startuml
actor Client
participant Gateway
participant RealtimeService

Client -> Gateway: HTTP Upgrade to WebSocket
Gateway -> RealtimeService: establish session
Client <-> RealtimeService: bidirectional messages
RealtimeService -> Client: heartbeat/ping
Client -> RealtimeService: pong
@enduml
```

## Практические аспекты

| Тема | Рекомендация |
| --- | --- |
| Auth | проверяйте токен на handshake и при renew |
| Heartbeat | ping/pong с таймаутом для детекта обрывов |
| Reconnect | exponential backoff + jitter |
| Backpressure | лимиты очередей и drop policy |
| Ordering | фиксируйте sequence number в сообщениях |

## HA и масштабирование

- sticky sessions или shared session store;
- горизонтальный scale через shard key (tenant/user/topic);
- publish через broker (Kafka/RabbitMQ/NATS) в websocket nodes;
- graceful shutdown соединений при deploy.

## Безопасность

- используйте WSS, а не WS;
- ограничивайте origins и CORS-политику;
- изолируйте каналы по tenant и scope;
- вводите лимиты на message size и частоту сообщений.

## Fallback

- если WebSocket недоступен: SSE для server push;
- для старых клиентов: long polling;
- явно документируйте деградацию и поведение клиента.

## Типичные ошибки

- отсутствие reconnect policy на клиенте;
- нет heartbeats и таймаутов;
- один общий канал для всех типов сообщений;
- непредусмотренные bursts приводят к переполнению очередей.

## Контрольные вопросы

1. Как приложение восстанавливает соединение после обрыва?
2. Как ограничивается частота и размер сообщений?
3. Где хранится состояние подписок в multi-node кластере?
4. Какие fallback-механизмы поддерживаются клиентом?

## Чек-лист самопроверки

- handshake и auth строго определены;
- heartbeat/reconnect/backpressure реализованы;
- масштабирование и HA стратегия задокументированы;
- безопасность WSS и tenant isolation включены;
- есть fallback и тесты деградации.

## Стандарты и источники

- RFC 6455 WebSocket: <https://www.rfc-editor.org/rfc/rfc6455>
- STOMP: <https://stomp.github.io/>
- MQTT v5: <https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html>
