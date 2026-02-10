# SOA

SOA (Service-Oriented Architecture) строит интеграционный ландшафт enterprise-систем через контрактно-ориентированные сервисы и централизованный governance.

## Уровни сложности

### Базовый уровень

- понимать идею сервисных контрактов и loose coupling;
- отличать SOA от просто "набора [API](../../../glossary.md#abbr-005)";
- учитывать роль ESB/интеграционного слоя.

### Средний уровень

- проектировать lifecycle контрактов и версий;
- управлять [SLA](../../../glossary.md#abbr-079) и каталогом сервисов;
- обеспечивать совместимость множества потребителей.

### Продвинутый уровень

- выстраивать SOA governance на уровне организации;
- управлять миграцией от ESB-heavy к гибридной архитектуре;
- объединять SOA и event-driven интеграции.

## Структура SOA

```kroki-plantuml
@startuml
left to right direction
rectangle "Consumer A" as A
rectangle "Consumer B" as B
rectangle "ESB / Integration Layer" as ESB
rectangle "Service 1" as S1
rectangle "Service 2" as S2
A --> ESB
B --> ESB
ESB --> S1
ESB --> S2
@enduml
```

## Преимущества

- стандартизированные контракты для enterprise;
- повторное использование сервисов;
- централизованный контроль политик.

## Недостатки

- возможное узкое место ESB;
- heavy governance замедляет изменения;
- риск крупных централизованных зависимостей.

## SOA vs микросервисы

| Критерий | SOA | Микросервисы |
| --- | --- | --- |
| Фокус | enterprise-интеграция | автономные продуктовые домены |
| Governance | централизованный | более децентрализованный |
| Data ownership | чаще shared contracts | database per service |
| Темп изменений | умеренный/регламентный | быстрый и независимый |

## Антипаттерны

- ESB как "центральный мозг" бизнес-логики;
- универсальные сервисы без явного домена;
- отсутствие стратегии депрекации контрактов.

## Практические рекомендации

1. Используйте contract-first и version policy.
2. Разделяйте orchestration и routing.
3. Введите consumer impact analysis для изменений.
4. Свяжите SOA-практики с [разделом интеграций](../../../integrations/index.md).
## Стандарты и источники

- Enterprise Integration Patterns.
- TOGAF guidance on service architecture.
