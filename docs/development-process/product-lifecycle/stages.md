# Этапы жизненного цикла ПО

Страница детализирует SDLC по фазам: цели, входы, выходы, роли, артефакты, критерии перехода и типовые ошибки.

## Уровни сложности

### Базовый уровень

- знать цели и результат каждой фазы;
- различать входные и выходные артефакты;
- понимать роль аналитика в фазовом переходе.

### Средний уровень

- формировать [DoR](../../glossary.md#abbr-027)/[DoD](../../glossary.md#abbr-026) и quality gates;
- управлять зависимостями между фазами;
- адаптировать фазовый контур под Agile и гибридные модели.

### Продвинутый уровень

- работать с крупными программами и многоуровневым governance;
- настраивать метрики процесса и управления рисками;
- применять вариации SDLC для web/mobile/embedded продуктов.

## Фазы SDLC: входы, выходы, роли

| Фаза | Цель | Входы | Выходы | Ключевые роли |
| --- | --- | --- | --- | --- |
| Инициация | подтвердить целесообразность | стратегия, бизнес-проблема, ограничения | Vision/Scope, Business Case, high-level roadmap | Sponsor, [PO](../../glossary.md#abbr-065), BA, PM |
| Анализ | сформировать проверяемые требования | vision, stakeholder map, текущие процессы | [BRD](../../glossary.md#abbr-010)/[SRS](../../glossary.md#abbr-085), backlog, [NFR](../../glossary.md#abbr-053), RTM baseline | BA/SA, PO, архитектор, [QA](../../glossary.md#abbr-067) |
| Дизайн | выбрать и обосновать решение | требования, ограничения, NFR | [C4](../../glossary.md#abbr-011)/[UML](../../glossary.md#abbr-092)/ER, [API](../../glossary.md#abbr-005) contracts, [ADR](../../glossary.md#abbr-003), [UX](../../glossary.md#abbr-093) прототипы | Архитектор, SA, lead dev |
| Разработка | реализовать инкремент | дизайн, backlog, DoR | код, PR, unit tests, changelog | Dev team, SA |
| Тестирование | подтвердить качество | код, test plan, [AC](../../glossary.md#abbr-002) | test report, defect log, [UAT](../../glossary.md#abbr-089) decision | QA, BA/SA, PO |
| Внедрение | безопасно выпустить | release package, runbook, rollback plan | production release, release notes | DevOps/SRE, PM, PO |
| Эксплуатация | обеспечить стабильность и улучшения | production signals, incident data | [SLI](../../glossary.md#abbr-080)/[SLO](../../glossary.md#abbr-081) review, postmortem, improvement backlog | SRE, support, SA, PO |

## Документы и артефакты по фазам

### Инициация

- Vision/Scope;
- Business Case ([ROI](../../glossary.md#abbr-073)/[NPV](../../glossary.md#abbr-055)/риски);
- карта стейкхолдеров.

### Анализ

- BRD/SRS или набор спецификаций в backlog;
- Use Case/User Story/[JTBD](../../glossary.md#abbr-045);
- критерии приемки и NFR;
- decision log.

### Дизайн

- C4-контекст и контейнеры;
- ER-диаграммы и data contracts;
- API-контракты;
- ADR.

### Разработка и тестирование

- PR-шаблоны, code review notes;
- test cases/test suites;
- defect log;
- traceability updates.

### Внедрение и эксплуатация

- release checklist;
- runbook/operations manual;
- мониторинг и alert policy;
- backlog улучшений и техдолга.

## Критерии перехода между фазами

| Переход | Минимальные критерии |
| --- | --- |
| Инициация -> Анализ | согласована цель и бизнес-метрики успеха |
| Анализ -> Дизайн | требования testable, согласованы AC/NFR |
| Дизайн -> Разработка | ключевые ADR приняты, риски оценены |
| Разработка -> Тестирование | код-ревью и базовые проверки пройдены |
| Тестирование -> Внедрение | quality gates и UAT выполнены |
| Внедрение -> Эксплуатация | runbook, monitoring, rollback подтверждены |

## Definition of Ready / Definition of Done

### DoR (пример)

- user story/use case понятны и не содержат противоречий;
- AC и NFR измеримы;
- зависимости и внешние контракты определены;
- есть тестовые данные и критерии проверки.

### DoD (пример)

- функциональность реализована и протестирована;
- автоматические проверки зеленые;
- документация обновлена;
- эксплуатационные аспекты покрыты (алерты, логирование, runbook).

## Ошибки при фазовых переходах

- старт разработки без согласованных AC;
- дизайн без проверки эксплуатационных сценариев;
- релиз без подтвержденного rollback-плана;
- эксплуатация без post-release review и backlog улучшений.

## Метрики SDLC

| Область | [Метрика](../../glossary.md#term-044) | Как интерпретировать |
| --- | --- | --- |
| Скорость поставки | Lead Time for Changes | меньше = быстрее поток |
| Качество | Change Failure Rate | меньше = стабильнее релизы |
| Восстановление | [MTTR](../../glossary.md#abbr-051) | меньше = быстрее реакция |
| Предсказуемость | Plan vs Actual | ближе к 1 = стабильное планирование |

## Вариации SDLC по типам продуктов

| Тип продукта | Что усиливать |
| --- | --- |
| Web | непрерывные релизы, observability, [A/B](../../glossary.md#abbr-001)-практики |
| Mobile | релизный менеджмент в App Store/Google Play, backward compatibility |
| Embedded/IoT | safety/security testing, hardware-in-the-loop, сертификационные этапы |

## Схема переходов с quality gate

```kroki-plantuml
skinparam monochrome true
start
:Фаза N завершена;
:Проверить входы/выходы и риски;
if (Gate пройден?) then (Да)
  :Переход к фазе N+1;
else (Нет)
  :Коррекция артефактов и mitigation;
endif
stop
```## Стандарты и источники

- [ISO](../../glossary.md#abbr-043)/IEC/[IEEE](../../glossary.md#abbr-041) 12207: <https://www.iso.org/standard/63712.html>
- ISO/IEC/IEEE 29148 (требования): <https://www.iso.org/standard/72089.html>
- IEEE 730 (quality assurance): <https://standards.ieee.org/>
