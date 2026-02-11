# [Оркестрация](../../glossary.md#term-051) и хореография

Это два подхода к координации распределенных процессов: централизованное управление и децентрализованная реакция на события.

## Уровни сложности

### Базовый уровень

- различать orchestration и choreography;
- понимать где нужен контроль последовательности;
- учитывать компенсации в распределенных процессах.

### Средний уровень

- проектировать saga-потоки;
- выбирать инструмент оркестрации;
- обеспечивать трассировку end-to-end.

### Продвинутый уровень

- комбинировать подходы по доменам;
- управлять failure semantics и replay;
- предотвращать SPOF и coupling проблем.

## Оркестрация

- Централизованный workflow-движок управляет шагами.
- Примеры инструментов: Camunda, Temporal, Zeebe.

```kroki-plantuml
@startuml
participant Orchestrator
participant Order
participant Payment
participant Inventory
Orchestrator -> Order: create
Orchestrator -> Payment: authorize
alt payment ok
  Orchestrator -> Inventory: reserve
else payment fail
  Orchestrator -> Order: cancel
end
@enduml
```

## [Хореография](../../glossary.md#term-076)

- Сервисы реагируют на доменные события без центрального управляющего.

```kroki-plantuml
@startuml
queue Bus
participant Order
participant Payment
participant Inventory
Order -> Bus: OrderPlaced
Bus -> Payment: handle
Payment -> Bus: PaymentAuthorized
Bus -> Inventory: reserve stock
@enduml
```

## Плюсы и минусы

| Подход | Плюсы | Минусы |
| --- | --- | --- |
| [Оркестрация](../../glossary.md#term-051) | высокий контроль и прозрачность | риск central bottleneck |
| [Хореография](../../glossary.md#term-076) | автономность и масштабируемость | сложнее отладка и governance |

## Когда что выбирать

- Оркестрация: регламентные процессы, строгий [SLA](../../glossary.md#abbr-079), аудит шагов.
- Хореография: слабосвязанные доменные события и автономные команды.

## Типичные ошибки

- оркестратор как "бог-объект" всей бизнес-логики;
- хореография без event contracts и observability;
- отсутствие компенсационных действий.

Кросс-ссылка: [Saga и интеграционные паттерны](../../integrations/integration-methods/patterns.md).
## Стандарты и источники

- Temporal docs: <https://docs.temporal.io/>
- Camunda docs: <https://docs.camunda.org/>
- Microservices saga patterns (microservices.io).
