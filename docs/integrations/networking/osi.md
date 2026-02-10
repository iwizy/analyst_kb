# Модель OSI

Модель OSI помогает структурировать диагностику интеграционных проблем по слоям: от физики до приложений.

## Уровни сложности

### Базовый уровень

- знать 7 уровней OSI и их назначение;
- соотносить API-проблемы с уровнем стека;
- понимать различие OSI и TCP/IP.

### Средний уровень

- использовать OSI для incident triage;
- определять, где ломается интеграция: сеть, TLS, приложение;
- сопоставлять инструменты диагностики каждому уровню.

### Продвинутый уровень

- выстраивать системные runbooks по уровням;
- ускорять RCA через layer-by-layer анализ;
- стандартизировать сетевую диагностику в командах.

## Уровни OSI

| Уровень | Что делает | Пример в интеграциях |
| --- | --- | --- |
| 7 Application | прикладные протоколы | HTTP, gRPC, SOAP, WebSocket |
| 6 Presentation | форматы/кодирование | JSON, XML, Protobuf, TLS data formatting |
| 5 Session | управление сессиями | TLS session, WebSocket session |
| 4 Transport | доставка между хостами | TCP, UDP |
| 3 Network | маршрутизация | IP, routing |
| 2 Data Link | доставка в пределах канала | Ethernet, VLAN |
| 1 Physical | физическая передача | кабели, радио, оптика |

## OSI vs TCP/IP

```kroki-plantuml
@startuml
left to right direction
rectangle "OSI 7-5\nApplication/Presentation/Session" as O1
rectangle "OSI 4\nTransport" as O2
rectangle "OSI 3\nNetwork" as O3
rectangle "OSI 2-1\nLink/Physical" as O4

rectangle "TCP/IP Application" as T1
rectangle "TCP/IP Transport" as T2
rectangle "TCP/IP Internet" as T3
rectangle "TCP/IP Link" as T4

O1 --> T1
O2 --> T2
O3 --> T3
O4 --> T4
@enduml
```

## Диагностика по уровням

| Симптом | Вероятный уровень | Инструменты |
| --- | --- | --- |
| `connection timeout` | L3/L4 | ping, traceroute, mtr |
| TLS handshake fail | L5/L6 | openssl s_client, gateway logs |
| `429/503` | L7 | API metrics, gateway dashboards |
| потеря пакетов | L2/L3 | tcpdump, Wireshark |

## Контрольные вопросы

1. На каком уровне чаще всего возникают инциденты в вашем контуре?
2. Есть ли стандартный runbook диагностики по слоям?
3. Какие инструменты и метрики закреплены за каждым уровнем?
4. Где проходит граница ответственности network/platform/app команд?

## Чек-лист самопроверки

- команда использует OSI как общий язык диагностики;
- для каждого уровня определены базовые проверки;
- runbook содержит инструменты и expected outputs;
- зафиксированы эскалации по слоям;
- RCA документируется с привязкой к уровню.

## Стандарты и источники

- ISO/IEC 7498-1 (OSI reference model): <https://www.iso.org/standard/20269.html>
- RFC 1122 Host Requirements: <https://www.rfc-editor.org/rfc/rfc1122>
