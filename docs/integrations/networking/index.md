# Сетевое взаимодействие

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Подраздел дает прикладной минимум сетевых знаний для аналитика и архитектора интеграций: от модели OSI до диагностики latency и потерь.

## Уровни сложности

### Базовый уровень

- понимать связь OSI/TCP-IP и API-интеграций;
- различать TCP и UDP сценарии;
- читать базовые сетевые метрики (RTT, packet loss).

### Средний уровень

- учитывать влияние handshake, congestion и keepalive;
- выбирать протоколы HTTP/2, HTTP/3, WebSocket, gRPC;
- диагностировать проблемы через traceroute/tcpdump.

### Продвинутый уровень

- проектировать сетевую устойчивость и failover;
- оптимизировать socket tuning и connection pooling;
- выстраивать observability сетевого слоя в production.

## Что важно аналитикам и архитекторам

| Тема | На что влияет |
| --- | --- |
| RTT и jitter | latency API и UX |
| Packet loss | timeout/retry и надежность |
| Congestion control | throughput под нагрузкой |
| TLS handshake | стартовая задержка соединения |
| Connection reuse | эффективность high-RPS API |

## Практический минимум

1. Для критичных API фиксируйте `p95/p99 latency` и сетевые SLO.
2. Определяйте границы retry и timeout с учетом RTT.
3. Проверяйте MTU, TLS и keepalive в целевой среде.
4. Включайте сетевые метрики в общий observability dashboard.

## Переход к подразделам

- [Модель OSI](osi.md)
- [TCP/IP](tcp-ip.md)
- [UDP](udp.md)
- [Сокеты](sockets.md)
## Стандарты и источники

- RFC 9293 TCP: <https://www.rfc-editor.org/rfc/rfc9293>
- RFC 768 UDP: <https://www.rfc-editor.org/rfc/rfc768>
- RFC 9000 QUIC: <https://www.rfc-editor.org/rfc/rfc9000>
