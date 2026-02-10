# ITSM/ITIL процессы сопровождения

ITSM помогает управлять эксплуатацией как сервисом: с понятными ролями, SLA и контролем изменений. ITIL дает референс-практики, которые можно адаптировать под продуктовую команду.

## Уровни сложности

### Базовый уровень

- различать Incident, Problem, Change, Release;
- понимать, зачем нужны SLA и service catalog;
- вести базу знаний и runbook.

### Средний уровень

- внедрять процессы Incident/Problem/Change/Release;
- согласовывать CAB/CCB и release governance;
- интегрировать ITSM с DevOps и CI/CD.

### Продвинутый уровень

- строить service management для нескольких продуктовых команд;
- применять KPI ITSM (MTTR, FCR, change success rate);
- управлять непрерывным улучшением на основе сервисных данных.

## Ключевые ITIL-практики

| Практика | Назначение | Выход |
| --- | --- | --- |
| Incident Management | быстро восстановить сервис | восстановление SLA/SLO |
| Problem Management | устранить первопричины | known errors, preventive actions |
| Change Enablement | безопасно проводить изменения | approved change + audit trail |
| Release Management | управлять выпуском изменений | контролируемый релиз |
| Service Configuration Management | учитывать активы и связи | CMDB/реестр конфигураций |
| Knowledge Management | сохранять и переиспользовать опыт | статьи базы знаний, runbook |

## Взаимодействие разработки, QA и эксплуатации

```kroki-plantuml
skinparam monochrome true
start
:Разработка и тестирование изменений;
:Change review;
:Release и внедрение;
:Мониторинг и инциденты;
:Problem management и RCA;
:Обновление знаний и backlog;
stop
```

## SLO/SLI/SLA в сервисном контуре

- SLA: внешний договор с бизнесом/клиентом;
- SLO: внутренние цели команды;
- SLI: метрики, которыми это измеряется.

Практика: SLO должен быть строже или равен SLA, иначе команда не успевает реагировать до нарушения внешних обязательств.

## Runbook и operations manual

Минимальные разделы runbook:

- симптомы и триггеры инцидента;
- шаги диагностики;
- команды/скрипты восстановления;
- условия эскалации;
- критерий «инцидент закрыт».

## Работа с обратной связью и техдолгом

- инциденты и повторяющиеся обращения -> candidate в problem backlog;
- product feedback -> roadmap улучшений;
- операционные боли -> reliability/automation backlog;
- технический долг оценивается по влиянию на SLA и скорость изменений.

## Типовые ошибки

- ITSM «отдельно от разработки», без единого backlog;
- change-процесс без связи с реальными рисками;
- база знаний не обновляется после инцидентов;
- SLA есть, но нет SLO и operational owner.

## Чек-лист самопроверки

- определены сервисы, владельцы и SLA;
- Incident/Problem/Change процессы формально описаны;
- есть единая база знаний и runbook на критичные сценарии;
- postmortem и problem management дают измеримые улучшения.

## Контрольные вопросы

1. Чем Incident отличается от Problem на практике?
2. Какие изменения обязаны проходить CAB/CCB?
3. Где фиксируются known errors и обходные решения?
4. Как технический долг влияет на SLA/SLO?

## Стандарты и источники

- ITIL 4: <https://www.axelos.com/certifications/itil-service-management>
- ISO/IEC 20000: <https://www.iso.org/standard/70636.html>
- Service Management Body of Knowledge: <https://www.servicemanagementwiki.org/>
