# Сопровождение функциональности

Сопровождение начинается не после релиза, а на этапе проектирования. Цель раздела - показать, как обеспечить устойчивую эксплуатацию, быстрый отклик на инциденты и управляемое улучшение продукта.

## Уровни сложности

### Базовый уровень

- понимать различия Incident, Problem, Change;
- уметь читать дашборды метрик и алерты;
- знать назначение runbook и postmortem.

### Средний уровень

- формировать [SLI](../../glossary.md#abbr-080)/[SLO](../../glossary.md#abbr-081)/[SLA](../../glossary.md#abbr-079) и эксплуатационные требования;
- организовывать процесс инцидент-менеджмента и [RCA](../../glossary.md#abbr-070);
- связывать операционные проблемы с backlog улучшений.

### Продвинутый уровень

- выстраивать ITSM/[ITIL](../../glossary.md#abbr-044)-контур в продуктовой организации;
- балансировать feature delivery и reliability work;
- управлять техдолгом на основе production-данных.

## Что включает раздел

- [Мониторинг и логирование](monitoring-logging.md)
- [Разбор инцидентов](incident-analysis.md)
- [Основы SRE](sre-basics.md)
- [ITSM/ITIL процессы сопровождения](itsm-itil.md)

## Сквозной эксплуатационный цикл

```kroki-plantuml
skinparam monochrome true
start
:Мониторинг и алерты;
:Реакция на инцидент;
:Восстановление сервиса;
:Postmortem и RCA;
:Задачи в backlog (quality/reliability);
:Внедрение улучшений;
stop
```

## Кросс-ссылки

- [Основы DevOps](../product-lifecycle/devops-basics.md)
- [Основы CI/CD](../product-lifecycle/cicd-basics.md)
- [Качество, документация и риски](../quality-documentation-risks.md)
- [Интеграции: паттерны надежности](../../integrations/integration-methods/reliability-patterns.md)

## Стандарты и источники

- [ITIL](../../glossary.md#abbr-044) 4: <https://www.axelos.com/certifications/itil-service-management>
- Google SRE book: <https://sre.google/books/>
- NIST incident handling (SP 800-61): <https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final>
