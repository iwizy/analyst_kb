# Оркестрация и хореография

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

## Хореография

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
| Оркестрация | высокий контроль и прозрачность | риск central bottleneck |
| Хореография | автономность и масштабируемость | сложнее отладка и governance |

## Когда что выбирать

- Оркестрация: регламентные процессы, строгий SLA, аудит шагов.
- Хореография: слабосвязанные доменные события и автономные команды.

## Типичные ошибки

- оркестратор как "бог-объект" всей бизнес-логики;
- хореография без event contracts и observability;
- отсутствие компенсационных действий.

Кросс-ссылка: [Saga и интеграционные паттерны](../../integrations/integration-methods/patterns.md).

## Контрольные вопросы

1. Нужен ли вам централизованный контроль процесса?
2. Где должен жить rollback/compensation logic?
3. Как обеспечить traceability в выбранном подходе?
4. Какой риск SPOF в orchestration сценарии?

## Чек-лист самопроверки

- выбран подход под бизнес-процесс;
- определены компенсации;
- настроены tracing и correlation IDs;
- есть политика versioning событий/команд;
- определен owner процесса.

## Стандарты и источники

- Temporal docs: <https://docs.temporal.io/>
- Camunda docs: <https://docs.camunda.org/>
- Microservices saga patterns (microservices.io).
