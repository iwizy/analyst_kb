# Основы тестирования

Системный аналитик влияет на качество через тестируемые требования, корректные критерии приемки и трассировку до тест-кейсов.

## Уровни сложности

### Базовый уровень

- понимать уровни тестирования: unit, integration, system, acceptance;
- формулировать проверяемые acceptance criteria;
- покрывать positive/negative сценарии.

### Средний уровень

- строить traceability `requirement -> test case`;
- участвовать в тест-дизайне с [QA](../glossary.md#abbr-067);
- готовить [UAT](../glossary.md#abbr-089)-сценарии для бизнеса.

### Продвинутый уровень

- внедрять quality gates и risk-based testing;
- поддерживать [BDD](../glossary.md#abbr-007)/ATDD-практики;
- контролировать регрессии на уровне процесса.

## Роль аналитика в тестировании

| Этап | Вклад аналитика |
| --- | --- |
| Подготовка | уточнение scope и [AC](../glossary.md#abbr-002), описание рисков |
| Дизайн тестов | edge cases, бизнес-правила, ограничения |
| Выполнение | поддержка QA по неоднозначным сценариям |
| Приемка | UAT, фиксация отклонений и решений |

## Уровни и типы тестов

| Категория | Что проверяет | Частые ошибки |
| --- | --- | --- |
| Unit | корректность модуля | ожидание, что unit заменит интеграцию |
| Integration | взаимодействие сервисов/БД/[API](../glossary.md#abbr-005) | неучтенные контракты и таймауты |
| System | поведение всей системы | тесты без реалистичных данных |
| Acceptance | соответствие бизнес-ожиданиям | AC не измеримы |
| Performance | [SLA](../glossary.md#abbr-079) под нагрузкой | отсутствие realistic profile |
| Security | угрозы и уязвимости | скан без threat model |

## Шаблоны артефактов

### Test Plan (минимум)

| Поле | Содержание |
| --- | --- |
| Scope | что тестируем/что не тестируем |
| Strategy | уровни тестов и инструменты |
| Environment | стенды и тестовые данные |
| Entry/Exit Criteria | условия старта/завершения |
| Risks | ключевые тестовые риски |

### Test Case (минимум)

| Поле | Содержание |
| --- | --- |
| ID | TC-XXX |
| Requirement Link | ссылка на требование |
| Preconditions | начальное состояние |
| Steps | шаги выполнения |
| Expected Result | ожидаемый результат |
| Priority | High/Medium/Low |

### Traceability Matrix (пример)

| Requirement | Test Case | Статус |
| --- | --- | --- |
| REQ-145 | TC-212, TC-213 | Passed |
| REQ-151 | TC-224 | Failed |

## Автоматизация: TDD, BDD, ATDD

- TDD: разработка через unit-тесты.
- BDD: спецификация поведения в формате Given/When/Then.
- ATDD: критерии приемки формируются до реализации.

Инструменты:

- Unit: JUnit, pytest;
- [UI](../glossary.md#abbr-091)/API: Selenium, Playwright, Postman/Newman;
- BDD: Cucumber, Behave.

## Типичные ошибки

- AC формата "система работает быстро" без метрик;
- нет покрытия негативных и граничных сценариев;
- отсутствует связь тестов с требованиями;
- дефекты фиксируются без воспроизводимых шагов.

## Кросс-ссылки

- [Тестирование в процессе разработки](../development-process/testing/index.md)
- [Валидация требований](../requirements/validation.md)
- [Трассировка](../requirements/management/traceability.md)

## Источники

- ISTQB Foundation: <https://www.istqb.org/>
- Google Testing Blog: <https://testing.googleblog.com/>
- Cucumber docs: <https://cucumber.io/docs/>
