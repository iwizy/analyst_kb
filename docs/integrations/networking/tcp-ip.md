# TCP/IP

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


TCP/IP — основной стек для большинства интеграций. Понимание его поведения помогает правильно настраивать таймауты, ретраи и балансировку.

## Уровни сложности

### Базовый уровень

- понимать роли уровней TCP/IP;
- знать TCP handshake и базовые состояния соединения;
- связывать RTT и timeout API.

### Средний уровень

- учитывать congestion control и keepalive;
- понимать влияние HTTP/2 и HTTP/3 на latency;
- проектировать connection pooling.

### Продвинутый уровень

- оптимизировать сетевые параметры под high-load;
- управлять деградациями в multi-region;
- выбирать CUBIC/BBR/QUIC под профиль трафика.

## Уровни стека TCP/IP

| Уровень | Назначение |
| --- | --- |
| Application | HTTP, gRPC, DNS, SMTP |
| Transport | TCP/UDP |
| Internet | IP, ICMP, routing |
| Link | Ethernet, Wi-Fi |

## TCP handshake

```kroki-plantuml
@startuml
participant Client
participant Server
Client -> Server: SYN
Server --> Client: SYN-ACK
Client -> Server: ACK
Client <-> Server: Data transfer
@enduml
```

## Что важно для интеграций

| Тема | Практика |
| --- | --- |
| TCP keepalive | выявляйте "мертвые" соединения |
| Congestion control | учитывайте CUBIC/BBR при throughput тестах |
| Head-of-line blocking | для HTTP/1.1 выше, HTTP/2 снижает |
| Connection pooling | уменьшает стоимость handshakes |
| TLS reuse | снижает latency повторных вызовов |

## HTTP/2 и HTTP/3

- HTTP/2: multiplexing и header compression;
- HTTP/3: поверх QUIC, лучше при потере пакетов;
- выбор зависит от среды клиентов и поддерживаемой инфраструктуры.

## Диагностика

- `mtr`/`traceroute` для поиска сетевого узкого места;
- `tcpdump`/Wireshark для анализа retransmission;
- gateway/service metrics для связи сетевых и прикладных ошибок.
## Стандарты и источники

- RFC 9293 TCP: <https://www.rfc-editor.org/rfc/rfc9293>
- RFC 793 (исторически): <https://www.rfc-editor.org/rfc/rfc793>
- RFC 7540 HTTP/2: <https://www.rfc-editor.org/rfc/rfc7540>
- RFC 9114 HTTP/3: <https://www.rfc-editor.org/rfc/rfc9114>
