# Основы CI/CD

CI/CD это инженерный контур, который превращает изменение в коде в безопасно доставленную функциональность с контролем качества и обратной связью.

## Уровни сложности

### Базовый уровень

- понимать этапы pipeline: build -> test -> deploy -> monitor;
- различать Continuous Delivery и Continuous Deployment;
- знать обязательные quality gates.

### Средний уровень

- проектировать pipeline под тип продукта и риски;
- настраивать branch protection, approvals, artifact management;
- внедрять canary/blue-green и rollback-процедуры.

### Продвинутый уровень

- автоматизировать contract testing и schema evolution;
- строить multi-environment delivery с policy-as-code;
- использовать deployment-метрики для оптимизации потока.

## Этапы CI/CD pipeline

| Этап | Проверки | Результат |
| --- | --- | --- |
| Source | PR, code review, lint | валидный change-set |
| Build | сборка, dependency checks | артефакт версии |
| Test | unit/integration/contract/security | подтвержденное качество |
| Deploy | staging/prod rollout | релиз в целевой среде |
| Verify | smoke + synthetic checks | подтверждение работоспособности |
| Observe | metrics/logs/traces | решение keep/rollback |

## Типовой pipeline (схема)

```kroki-plantuml
skinparam monochrome true
start
:Commit/PR;
:Build и unit tests;
if (OK?) then (Да)
  :Integration и contract tests;
  if (OK?) then (Да)
    :Deploy в staging;
    :Smoke tests;
    if (Approval/Auto policy?) then (Да)
      :Canary/Blue-Green в production;
      :Мониторинг и release verification;
    else (Нет)
      :Hold release;
    endif
  else (Нет)
    :Исправить дефекты;
  endif
else (Нет)
  :Исправить сборку;
endif
stop
```

## Пример GitHub Actions (фрагмент)

```yaml
name: ci-cd
on:
  pull_request:
  push:
    branches: [main]
jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: ./gradlew test
      - run: ./gradlew build
```

## Пример GitLab CI (фрагмент)

```yaml
stages: [build, test, deploy]
build:
  stage: build
  script: ./mvnw -q package
test:
  stage: test
  script: ./mvnw -q test
```

## Рекомендации по выбору платформы

- Jenkins: когда нужна сложная кастомизация и контроль on-prem;
- GitLab CI: когда нужен единый контур SCM + CI/CD;
- GitHub Actions: быстрый старт для GitHub-экосистемы;
- Azure DevOps: корпоративные команды Microsoft-стека.

## Quality checklist для CI/CD

- тестовое покрытие и quality threshold определены;
- статический анализ и dependency scanning обязательны;
- секреты и ключи управляются безопасно;
- approvals настроены для критичных релизов;
- поддерживаются canary + rollback сценарии.

## Типичные ошибки

- pipeline проверяет только сборку без интеграционных тестов;
- деплой в production без release verification;
- отсутствие версионирования артефактов и changelog;
- ручные неповторяемые шаги в критическом контуре.

## Контрольные вопросы

1. Чем Continuous Delivery отличается от Continuous Deployment?
2. Какие quality gates обязательны перед production?
3. Как вы подтверждаете, что релиз безопасен после деплоя?
4. Какие действия запускают автоматический rollback?

## Чек-лист самопроверки

- pipeline воспроизводим и прозрачен;
- контроль качества встроен на ранних этапах;
- релизные стратегии учитывают риск и критичность сервиса;
- эксплуатационные сигналы влияют на релизные решения.

## Стандарты и источники

- Continuous Delivery (Humble/Farley): <https://continuousdelivery.com/>
- GitHub Actions docs: <https://docs.github.com/actions>
- GitLab CI/CD docs: <https://docs.gitlab.com/ee/ci/>
- Jenkins docs: <https://www.jenkins.io/doc/>
