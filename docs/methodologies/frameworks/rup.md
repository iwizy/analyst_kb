# RUP (Rational Unified Process)

RUP - итеративный процесс с формальной структурой фаз, дисциплин и артефактов. Подходит для крупных программ, где нужна управляемость и трассировка.

## Уровни сложности

### Базовый уровень

- знать 4 фазы RUP;
- понимать роль итераций внутри фаз;
- использовать базовые артефакты Vision, Use Case Model, Architecture Baseline.

### Средний уровень

- управлять переходами между фазами через критерии готовности;
- выстраивать дисциплины требований, анализа, разработки и тестирования;
- поддерживать traceability и change control.

### Продвинутый уровень

- адаптировать RUP под enterprise governance;
- интегрировать RUP с Agile delivery-практиками;
- использовать RUP для compliance-heavy программ.

## Фазы RUP

| Фаза | Цель | Типовые результаты |
| --- | --- | --- |
| Inception | обосновать проект | Vision, Business Case, high-level scope |
| Elaboration | снять ключевые риски и стабилизировать архитектуру | Use-Case Model, Architecture Baseline, Risk List |
| Construction | реализовать и протестировать решение | increments, test artifacts |
| Transition | вывести в эксплуатацию | release package, training, support plan |

## Дисциплины RUP

- Business Modeling;
- Requirements;
- Analysis & Design;
- Implementation;
- Test;
- Deployment;
- Configuration & Change Management;
- Project Management;
- Environment.

## Схема фаз и итераций

```kroki-plantuml
skinparam monochrome true
start
:Inception (итерации);
:Elaboration (итерации + risk mitigation);
:Construction (итерации + increments);
:Transition (релиз и внедрение);
stop
```

## Артефакты и роли

| Артефакт | Назначение |
| --- | --- |
| Vision | целевой результат и границы |
| Use Case Model | функциональная модель |
| Architecture Description | архитектурный baseline |
| Iteration Plan | план текущей итерации |
| Risk List | управление рисками |
| Test Plan/Report | контроль качества |

Роли: business analyst, system analyst, architect, developer, tester, PM.

## Плюсы и ограничения

Плюсы:

- сильная управляемость и прозрачность процесса;
- хорошая совместимость с audit/compliance;
- баланс итеративности и формального контроля.

Ограничения:

- высокий overhead внедрения;
- риск бюрократии при малых проектах;
- требует зрелого проектного управления.

## Пример проекта

Государственная цифровая платформа с обязательным audit trail, сложными интеграциями и многоуровневым согласованием.

## Связь с требованиями и рисками

- требования формализуются и трассируются по фазам;
- изменения проходят controlled change process;
- Elaboration фокусируется на закрытии архитектурных и интеграционных рисков.

## Типичные ошибки

- попытка применять полный RUP к малым продуктовым задачам;
- игнорирование итеративности внутри фаз;
- переизбыток артефактов без операционной ценности.## Источники

- IBM RUP docs: <https://www.ibm.com/docs/en/rational-soft-arch>
- Kruchten, *The Rational Unified Process*.
