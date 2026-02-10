# Предсказуемые методологии: Waterfall и варианты

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Предсказуемые подходы применяются там, где важны контроль, формальная документация и трассируемость. Они особенно эффективны при стабильных требованиях и высокой цене ошибки.

## Уровни сложности

### Базовый уровень

- понимать последовательность фаз и stage-gates;
- знать обязательные артефакты (BRD/SRS, test plan, release docs);
- различать Waterfall, V-Model, Spiral и Incremental.

### Средний уровень

- управлять baseline требований и change control;
- формировать traceability и audit trail;
- применять риск-ориентированные практики (например, Spiral).

### Продвинутый уровень

- адаптировать предсказуемые подходы под enterprise-комплаенс;
- сочетать predictive и adaptive части процесса;
- измерять эффективность процесса и снижать process overhead.

## Waterfall: базовая схема

```kroki-plantuml
skinparam monochrome true
start
:Сбор и фиксация требований;
:Проектирование;
:Реализация;
:Тестирование;
:Внедрение;
:Эксплуатация;
stop
```

## Артефакты и роли

| Фаза | Артефакты | Ключевые роли |
| --- | --- | --- |
| Анализ | Vision/Scope, BRD, SRS | BA/SA, PO, бизнес-владелец |
| Дизайн | архитектурные схемы, ADR, data model | архитектор, SA |
| Реализация | код, review records | dev team |
| Тестирование | test plan, test cases, defect log, RTM | QA, SA |
| Внедрение | release checklist, runbook, rollback plan | DevOps/SRE, PM |

### Шаблон BRD (минимум)

| Раздел | Содержание |
| --- | --- |
| Business goals | бизнес-цель и KPI |
| Scope | в границах / вне границ |
| Stakeholders | роли и ответственность |
| High-level requirements | ключевые требования |
| Constraints | регуляторные, технические, организационные |
| Acceptance criteria | критерии приемки решения |

### Шаблон SRS (минимум)

| Раздел | Содержание |
| --- | --- |
| Functional requirements | функциональные сценарии и правила |
| Non-functional requirements | производительность, надежность, безопасность |
| External interfaces | API, протоколы, форматы данных |
| Data requirements | сущности, атрибуты, ограничения |
| Verification criteria | как проверяется каждое требование |

## Где predictive-подходы наиболее уместны

- медицинские и safety-critical системы;
- инфраструктурные внедрения и крупные интеграционные программы;
- проекты с обязательным внешним аудитом;
- контрактные проекты с формальными acceptance-милестоунами.

## Связь с требованиями

- требования собираются и формально baseline-фиксируются до разработки;
- изменения проходят через change request и impact analysis;
- для критичных систем обязательна полная трассировка requirement -> test -> release.

## Связь с рисками и качеством

- верификация/валидация встроены в stage-gate точки;
- audit trail обязателен для ключевых решений;
- risk register пересматривается перед переходом фаз.

## Варианты и комбинации

- [V-Model](v-model.md): усиленный контур верификации и валидации.
- [Spiral](spiral.md): управление рисками через итерационные витки.
- [Incremental](incremental.md): поставка по инкрементам при сохранении формального контроля.
- Stage-Gate: формальные точки go/no-go между этапами.
- Water-Scrum-Fall: predictive upstream/downstream + agile delivery.
- Incremental + Spiral: поставка инкрементов с риск-оценкой на каждом витке.
- [RUP](../frameworks/rup.md): итеративный predictive-подход с дисциплинами и артефактами.

| Вариант | Ключевая идея | Когда использовать |
| --- | --- | --- |
| Stage-Gate | формальные контрольные точки между стадиями | high-compliance и капиталоемкие проекты |
| Water-Scrum-Fall | регламентированный upstream/downstream + спринты в разработке | enterprise с обязательным release governance |
| Incremental + Spiral | поэтапная поставка с приоритетом риск-снижения | инновационные программы с высокой неопределенностью |

## Типичные ошибки

- чрезмерно рано «замораживать» неготовые требования;
- недооценка стоимости change request;
- формальные review без проверки реальных рисков;
- поздняя интеграция и тестирование.

## Кросс-ссылки

- [Требования: Управление изменениями](../../requirements/management/change-management.md)
- [Требования: Трассировка](../../requirements/management/traceability.md)
- [Процесс разработки: Этапы SDLC](../../development-process/product-lifecycle/stages.md)## Источники

- PMBOK Guide: <https://www.pmi.org/pmbok-guide-standards>
- ISO/IEC/IEEE 12207: <https://www.iso.org/standard/63712.html>
- NASA Systems Engineering Handbook (V&V practices): <https://www.nasa.gov/reference/systems-engineering-handbook/>
