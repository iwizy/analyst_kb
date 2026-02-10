# Основы DevOps

DevOps это совместная модель работы разработки, тестирования и эксплуатации, где скорость поставки и надежность продукта достигаются через автоматизацию, измеримость и непрерывную обратную связь.

## Уровни сложности

### Базовый уровень

- понимать DevOps как культуру, а не только набор инструментов;
- знать ключевые практики: [CI/CD](../../glossary.md#abbr-017), [IaC](../../glossary.md#abbr-039), observability;
- видеть связь между требованиями и эксплуатационными метриками.

### Средний уровень

- формировать требования к pipeline и мониторингу;
- описывать operational readiness до релиза;
- настраивать feedback loop из production в backlog.

### Продвинутый уровень

- применять GitOps/Platform Engineering практики;
- строить [SLO](../../glossary.md#abbr-081)-driven delivery и error-budget policy;
- учитывать FinOps и стоимость эксплуатации при проектировании.

## DevOps-практики

| Практика | Что решает | Типовые инструменты |
| --- | --- | --- |
| Continuous Integration | раннее обнаружение дефектов | GitHub Actions, GitLab CI, Jenkins |
| Continuous Delivery/Deployment | частые безопасные релизы | Argo CD, GitLab, Azure DevOps |
| Infrastructure as Code | воспроизводимость инфраструктуры | Terraform, Pulumi, Ansible |
| Continuous Testing | качество на ранних этапах | pytest, JUnit, Postman/Newman |
| Observability | управляемость production | Prometheus, Grafana, ELK, OpenTelemetry |
| Incident Management | снижение [MTTR](../../glossary.md#abbr-051) | PagerDuty, Opsgenie, Jira Service Management |

## Роль системного аналитика в DevOps-контуре

- формулирует [NFR](../../glossary.md#abbr-053) для pipeline, наблюдаемости и отказоустойчивости;
- описывает эксплуатационные сценарии: rollback, деградация, [SLA](../../glossary.md#abbr-079);
- помогает трассировать бизнес-цели к [SLI](../../glossary.md#abbr-080)/SLO и alerting policy;
- участвует в postmortem и формировании backlog улучшений.

## DevOps feedback loop

```kroki-plantuml
skinparam monochrome true
start
:Сбор требований и NFR;
:Реализация и тесты;
:Автодеплой;
:Мониторинг и инциденты;
:Postmortem и RCA;
:Улучшения в backlog;
stop
```

## Выбор [CI/CD](../../glossary.md#abbr-017) и DevOps-инструментов

| Платформа | Плюсы | Ограничения | Когда выбирать |
| --- | --- | --- | --- |
| GitHub Actions | быстро для GitHub-репозиториев | ограниченные enterprise workflow без доп. настройки | продуктовые команды на GitHub |
| GitLab CI | единая платформа SCM+CI/CD | сложность первоначальной настройки | команды с GitLab full-stack |
| Jenkins | гибкость и экосистема плагинов | высокий операционный overhead | сложные кастомные enterprise pipeline |
| Azure DevOps | интеграция с Microsoft stack | vendor lock-in риски | корпоративный ландшафт Microsoft |

## Рекомендации по настройке

- обязательные проверки перед merge: tests, lint, security scan;
- branch protection и review policy;
- versioned artifacts и контроль provenance;
- контролируемые rollout-стратегии (canary, blue/green);
- автоматический rollback для критичных сбоев.

## Тренды, которые стоит учитывать

- GitOps (декларативные deployment-модели через Git);
- Platform Engineering (self-service платформа для команд);
- FinOps (контроль стоимости инфраструктуры);
- policy-as-code и security-as-code.## Стандарты и источники

- DORA research: <https://dora.dev/research/>
- OpenTelemetry: <https://opentelemetry.io/docs/>
- Terraform docs: <https://developer.hashicorp.com/terraform/docs>
- GitOps principles (CNCF): <https://opengitops.dev/>
