# Сокеты

Сокеты — базовый механизм сетевого ввода/вывода. От их настройки зависит стабильность и производительность интеграций под нагрузкой.

## Уровни сложности

### Базовый уровень

- понимать модель client/server sockets;
- различать blocking и non-blocking I/O;
- применять базовые timeout и backlog.

### Средний уровень

- использовать `select/poll/epoll/kqueue`;
- настраивать connection pooling и keepalive;
- внедрять [TLS](../../glossary.md#abbr-088) termination и certificate management.

### Продвинутый уровень

- проектировать high-concurrency сетевые сервисы;
- оптимизировать buffers, backlog и kernel параметры;
- использовать балансировку L4/L7 и устойчивые reconnect-паттерны.

## Модель

| Компонент | Роль |
| --- | --- |
| Listening socket | принимает входящие соединения |
| Connection socket | отдельный канал для клиента |
| Socket buffers | прием/передача данных |
| Event loop | обработка non-blocking событий |

## Базовый поток TCP-сокетов

```kroki-plantuml
@startuml
participant Client
participant Server

Client -> Server: connect()
Server -> Server: accept()
Client <-> Server: send()/recv()
Client -> Server: close()
Server -> Server: close()
@enduml
```

## Blocking vs Non-blocking

| Режим | Плюсы | Минусы |
| --- | --- | --- |
| Blocking I/O | простота | плохо масштабируется при большом числе соединений |
| Non-blocking I/O | высокое масштабирование | сложнее реализация |

## Production tuning

- `backlog` под ожидаемый burst входящих соединений;
- размеры `recv/send buffers` под профиль payload;
- keepalive для долгоживущих соединений;
- connection pool на клиентской стороне;
- [TLS](../../glossary.md#abbr-088) termination на ingress/gateway.

## Балансировка и HA

- L4: LVS, NLB для raw throughput;
- L7: HAProxy, Envoy, NGINX для smart routing;
- sticky vs stateless подключения по сценарию.

## Диагностика

- `netstat`/`ss` для анализа соединений и состояний;
- `tcpdump`/Wireshark для packet-level разбора;
- `mtr`/`ping` для маршрута и потерь;
- correlation с [API](../../glossary.md#abbr-005) latency/error графиками.

## Типичные ошибки

- бесконтрольный рост соединений без pool limits;
- отсутствие timeout/keepalive;
- слишком маленький backlog при пиковых нагрузках;
- игнорирование TLS overhead и handshake cost.
## Стандарты и источники

- POSIX sockets overview: <https://pubs.opengroup.org/onlinepubs/9699919799/functions/socket.html>
- [RFC](../../glossary.md#abbr-072) 9293 TCP: <https://www.rfc-editor.org/rfc/rfc9293>
- Envoy docs: <https://www.envoyproxy.io/docs/>
