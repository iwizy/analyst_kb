# Модель OSI

OSI это референс-модель из 7 уровней, помогающая локализовать сетевые проблемы и проектировать интеграционные решения.

## Уровни OSI

1. Physical — среда передачи.
1. Data Link — кадры и MAC.
1. Network — маршрутизация (IP).
1. Transport — TCP/UDP.
1. Session — управление сеансами.
1. Presentation — сериализация/шифрование.
1. Application — HTTP, gRPC, AMQP, SMTP и т.д.

## Практическое соответствие с интеграциями

- REST/gRPC/WebSockets: Application + Transport;
- TLS: Presentation/Transport boundary;
- брокеры сообщений: Application, но зависят от Transport-ограничений.

## Диагностика по уровням

- нет линка/пакетов: L1-L2;
- нет маршрута: L3;
- timeouts/retransmit: L4;
- 4xx/5xx ошибки протокола: L7.

## Смежные материалы

- [TCP/IP](tcp-ip.md)
- [Сокеты](sockets.md)
