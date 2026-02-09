# TCP/IP

TCP/IP это практический стек интернета, на котором работают HTTP, gRPC, AMQP и большинство интеграционных протоколов.

## Уровни стека TCP/IP

- Link;
- Internet (IP);
- Transport (TCP/UDP);
- Application.

## TCP: что важно для интеграций

- гарантированная доставка;
- упорядоченность байтового потока;
- управление перегрузкой;
- retransmission при потерях.

## Влияние на API

- long-tail latency при packet loss;
- head-of-line blocking (в разных контекстах);
- важность timeout и connection pooling.

## Практические рекомендации

- настраивать timeout connect/read/write явно;
- использовать keep-alive и pool limits;
- мониторить retransmits, RTT, SYN backlog;
- учитывать TLS handshake cost при частых коротких соединениях.

## Смежные материалы

- [UDP](udp.md)
- [Паттерны надежности](../integration-methods/reliability-patterns.md)
