# Практические сценарии интеграций
Страница показывает, как выбирать интеграционные паттерны и технологии в реальных проектах с разными ограничениями по [SLA](../glossary.md#abbr-079), консистентности, безопасности и скорости доставки изменений.

## Уровни сложности

### Базовый уровень

- сопоставлять бизнес-сценарий и тип взаимодействия: [API](../glossary.md#abbr-005), события, файлы;
- формулировать минимальный контракт и модель ошибок;
- учитывать задержку, надежность и требования безопасности.

### Средний уровень

- комбинировать синхронные и асинхронные подходы;
- проектировать retry/idempotency/[DLQ](../glossary.md#abbr-030) для отказоустойчивости;
- связывать интеграционные решения с [RTO](../glossary.md#abbr-076)/[RPO](../glossary.md#abbr-074).

### Продвинутый уровень

- проектировать интеграционную платформу на уровне доменов;
- управлять эволюцией контрактов и обратной совместимостью;
- балансировать стоимость владения и операционную сложность.

## Единый шаблон анализа интеграционного сценария

| Блок | Что фиксировать | Пример |
| --- | --- | --- |
| Бизнес-цель | зачем нужна интеграция и какой эффект ожидается | сократить время подтверждения оплаты до 3 секунд |
| Участники | кто инициирует запрос и кто обрабатывает | mobile app, payment service, antifraud service |
| Характер взаимодействия | sync/async/batch, uni- или bi-directional | sync API + async события статусов |
| Нефункциональные требования | latency, availability, throughput, audit | p95 <= 200 ms, availability 99.95% |
| Риски | отказ downstream, дубли, задержки, breaking changes | временная недоступность провайдера оплаты |
| Механизмы защиты | timeout, retry, circuit breaker, DLQ, idempotency | retry с jitter + idempotency key + DLQ |

## Кейс 1. Fintech B2C: оплата в мобильном приложении

### Контекст

- клиент ожидает моментальный ответ об успешной оплате;
- процесс должен быть устойчив к сетевым сбоям;
- дублирование списания недопустимо.

### Рекомендуемый паттерн

- синхронный [REST](../glossary.md#abbr-071) для инициации платежа;
- асинхронное событие для финального статуса из процессинга;
- обязательная идемпотентность на уровне операции `POST /payments`.

```kroki-plantuml
@startuml
actor Client
participant "Mobile API" as API
participant "Payment Service" as PAY
queue "Event Bus" as BUS
participant "Notification Service" as NTF

Client -> API : POST /payments (Idempotency-Key)
API -> PAY : create payment
PAY --> API : accepted + payment_id
API --> Client : 202 Accepted
PAY -> BUS : PaymentStatusChanged
BUS -> NTF : event delivery
NTF -> Client : push with final status
@enduml
```

### Почему это работает

| Требование | Решение |
| --- | --- |
| быстрый ответ клиенту | sync API возвращает принятие операции |
| защита от повторов | idempotency key + hash payload |
| устойчивость к сбоям | retry + timeout + outbox/event delivery |

## Кейс 2. E-commerce: заказ, склад, доставка

### Контекст

- один бизнес-процесс проходит через несколько сервисов;
- частичный отказ не должен оставлять "висящие" заказы;
- нужны компенсационные действия.

### Рекомендуемый паттерн

- Saga orchestration для жизненного цикла заказа;
- единый оркестратор управляет переходами и компенсациями;
- событийная фиксация шагов для наблюдаемости и аудита.

```kroki-plantuml
@startuml
participant "Order Orchestrator" as ORC
participant "Inventory" as INV
participant "Payments" as PAY
participant "Delivery" as DLV

ORC -> INV : reserve items
INV --> ORC : reserved
ORC -> PAY : charge
PAY --> ORC : failed
ORC -> INV : release reservation (compensation)
INV --> ORC : released
@enduml
```

### Типичные риски

- отсутствие явных компенсаций для каждого шага;
- разные семантики статусов в сервисах без единого словаря;
- слишком длинные таймауты, блокирующие весь процесс.

## Кейс 3. Gov B2B: межведомственный обмен пакетами

### Контекст

- регламентный обмен данными по расписанию;
- обязательны подпись, шифрование и подтверждение доставки;
- важна юридическая значимость журнала обмена.

### Рекомендуемый паттерн

- SFTP/AS2 для пакетной передачи;
- контроль целостности (checksum) и электронная подпись;
- ack/nack протокол с повторной отправкой по политике.

### Минимальный поток

| Шаг | Действие |
| --- | --- |
| 1 | сформировать пакет и подписать |
| 2 | отправить в защищенный канал |
| 3 | получить техническое подтверждение доставки |
| 4 | выполнить валидацию содержимого |
| 5 | вернуть бизнес-подтверждение (accepted/rejected) |

## Кейс 4. Media platform: потоковые события просмотров

### Контекст

- высокий поток телеметрии (миллионы событий в час);
- аналитика near real-time;
- допустима eventual consistency, важна устойчивость ingestion.

### Рекомендуемый паттерн

- брокер сообщений (Kafka/Pulsar) как event backbone;
- разделение producer/consumer и масштабирование по partition;
- [DWH](../glossary.md#abbr-029) загрузка через stream processing.

### Практический выбор

| Критерий | API sync | Event streaming |
| --- | --- | --- |
| throughput | ограничен запрос-ответ моделью | высокий за счет partition и batch |
| coupling | выше | ниже, consumer-driven |
| replay данных | ограничен | поддерживается за счет хранения лога |

## Кейс 5. Внутренние микросервисы: API Gateway + Service Mesh

### Контекст

- десятки сервисов, единый вход для внешних клиентов;
- внутренние сервисы требуют mTLS и единой телеметрии;
- нужны централизованные политики лимитов и доступа.

### Рекомендуемый паттерн

- API Gateway на edge-уровне;
- Service Mesh для east-west трафика;
- единые политики auth, rate limit, retry, tracing.

```kroki-plantuml
@startuml
left to right direction
actor User
rectangle "API Gateway" as G
rectangle "Service Mesh" as M
rectangle "Svc A" as A
rectangle "Svc B" as B
database "DB" as DB

User --> G
G --> M
M --> A
M --> B
A --> DB
B --> DB
@enduml
```

## Матрица выбора подхода под сценарий

| Условие | Предпочтительный подход |
| --- | --- |
| критична мгновенная обратная связь пользователю | sync API |
| критична изоляция сервисов и независимое масштабирование | async messaging |
| регламентный обмен между организациями | file exchange |
| сложный долгоживущий бизнес-процесс | saga orchestration |
| множество внутренних сервисов и единая безопасность | gateway + service mesh |

## Связанные материалы

- [Введение в раздел «Интеграции»](index.md)
- [Проектирование API](api-design/index.md)
- [Паттерны интеграции](integration-methods/patterns.md)
- [Паттерны надежности](integration-methods/reliability-patterns.md)
- [Брокеры сообщений](integration-methods/message-brokers/index.md)
- [Сетевое взаимодействие](networking/index.md)

## Стандарты и источники

- RFC 9110 HTTP Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- RFC 9457 Problem Details: <https://www.rfc-editor.org/rfc/rfc9457>
- OAuth 2.1 draft: <https://datatracker.ietf.org/doc/draft-ietf-oauth-v2-1/>
- OpenAPI Specification: <https://spec.openapis.org/oas/latest.html>
- AsyncAPI Specification: <https://www.asyncapi.com/docs/reference/specification/latest>
- Enterprise Integration Patterns: <https://www.enterpriseintegrationpatterns.com/>
