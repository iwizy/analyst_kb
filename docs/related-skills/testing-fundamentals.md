# Основы тестирования

Знание тестирования помогает аналитику писать проверяемые требования и снижать дефекты на приемке.

## Уровни тестирования

| Тип | Что проверяет | Кто обычно выполняет |
| --- | --- | --- |
| Unit | логика функций/модулей | разработка |
| Integration | взаимодействие компонентов | разработка + QA |
| Acceptance | соответствие бизнес-требованиям | QA + бизнес + аналитик |
| Load | производительность под нагрузкой | perf/SRE/QA |

## Практический пример

Сценарий: оформление заказа.

- Unit: расчет скидки и итоговой суммы.
- Integration: Order Service + Payment Service + Inventory Service.
- Acceptance: пользователь может оформить заказ и получить подтверждение.
- Load: система держит 1000 RPS при p95 < 300 мс.

## Практика аналитика

- формулировать testable acceptance criteria;
- описывать edge cases и negative scenarios;
- связывать риски с обязательными тестами.

## Для дальнейшего изучения

- [Раздел тестирования](../development-process/testing/index.md)
- ISTQB Foundation syllabus: <https://www.istqb.org/certifications/certified-tester-foundation-level>
