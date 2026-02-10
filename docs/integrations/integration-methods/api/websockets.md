# WebSockets

WebSockets обеспечивают двунаправленный канал связи в реальном времени поверх одного долгоживущего соединения.

## Когда применять

- live-дашборды;
- чаты и коллаборация;
- streaming updates в торговых/мониторинговых системах;
- push-уведомления между сервисом и UI.

## Базовый поток

```kroki-plantuml
@startuml
actor Client
participant Server

Client -> Server: HTTP Upgrade (WebSocket)
Server --> Client: 101 Switching Protocols
Client <-> Server: bi-directional messages
@enduml
```

## Практические аспекты

- heartbeats (ping/pong);
- reconnect strategy и resume;
- backpressure и ограничение buffer;
- auth при установке соединения + re-auth на ротации токена.

## Достоинства

- низкая задержка;
- серверный push без polling;
- эффективный обмен частыми небольшими сообщениями.

## Ограничения

- сложнее балансировка и эксплуатация большого числа соединений;
- нужен протокол поверх WS для ack/retry/order;
- не заменяет полностью request/response API.

## Практические рекомендации

- использовать message envelope с `type`, `id`, `trace_id`;
- ограничивать max message size;
- проектировать fallback на SSE/polling для некоторых клиентов;
- метрики: connection count, reconnect rate, msg lag.

## Смежные материалы

- [Паттерны надежности](../reliability-patterns.md)
- [Сокеты](../../networking/sockets.md)
