# RabbitMQ

RabbitMQ удобен для task-oriented интеграций и сложной маршрутизации сообщений через exchange/queue модель.

## Уровни сложности

### Базовый уровень

- понимать exchange, queue, binding;
- использовать ack/nack и retry;
- настраивать DLX для неуспешных сообщений.

### Средний уровень

- выбирать exchange type под сценарий маршрутизации;
- настраивать TTL, priority queues и quorum queues;
- строить отказоустойчивый кластер.

### Продвинутый уровень

- внедрять federation/shovel для междатацентрового обмена;
- управлять backpressure и flow control;
- автоматизировать observability и capacity planning.

## Exchange types

| Тип | Как маршрутизирует | Когда применять |
| --- | --- | --- |
| direct | точное совпадение routing key | point-to-point команды |
| topic | шаблоны routing key | доменные события и фильтрация |
| fanout | broadcast всем связанным очередям | уведомления |
| headers | по заголовкам | сложная маршрутизация по метаданным |

## Поток

```kroki-plantuml
@startuml
actor Publisher
participant Exchange
participant QueueA
participant QueueDLQ
actor Consumer

Publisher -> Exchange: publish (routing key)
Exchange -> QueueA: route message
Consumer -> QueueA: consume
alt success
  Consumer -> QueueA: ack
else fail
  Consumer -> QueueA: nack
  QueueA -> QueueDLQ: dead letter
end
@enduml
```

## Практические настройки

| Параметр | Рекомендация |
| --- | --- |
| `prefetch` | ограничивайте для fair dispatch |
| TTL | задавайте для временных сообщений |
| DLX | обязательно для retry/DLQ сценариев |
| Quorum queue | для HA и отказоустойчивости |
| Priority queues | только при реальной необходимости |

## Quorum vs Classic queues

| Критерий | Quorum | Classic |
| --- | --- | --- |
| Надежность | выше, Raft-based | ниже в старых mirrored конфигурациях |
| Производительность | стабильная, но может быть дороже | может быть быстрее на простых кейсах |
| Рекомендация | default для критичных очередей | legacy/простой сценарий |

## Retry и delay

- через DLX + TTL (requeue после задержки);
- через `x-delayed-message` plugin;
- ограничивайте количество попыток и храните reason code.

## Мониторинг

| Метрика | Зачем |
| --- | --- |
| queue depth | накопление сообщений |
| ack rate | скорость успешной обработки |
| unacked messages | признаки зависших consumer |
| publish confirm latency | производительность продюсеров |
| node disk/memory alarm | риск остановки приема сообщений |

## Типичные ошибки

- бесконечный requeue без DLQ;
- отсутствие prefetch и saturation consumer;
- слишком много сложных routing patterns без governance;
- неучтенная устойчивость при отказе узла.
## Стандарты и источники

- RabbitMQ docs: <https://www.rabbitmq.com/documentation.html>
- RabbitMQ quorum queues: <https://www.rabbitmq.com/quorum-queues.html>
