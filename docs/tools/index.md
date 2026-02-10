# Инструменты

Раздел собран как практический гид по выбору, внедрению и эксплуатации инструментов системного аналитика. Фокус: подобрать минимально достаточный стек, который поддерживает полный цикл от требований до эксплуатации.

## Уровни сложности

### Базовый уровень

- понимать классы инструментов и их назначение;
- уметь выбрать инструмент под конкретный артефакт;
- знать минимальные требования к хранению и версионированию.

### Средний уровень

- проектировать единый toolchain для команды;
- настраивать интеграции между инструментами;
- измерять влияние инструментов на скорость и качество.

### Продвинутый уровень

- выбирать целевую платформу для нескольких команд;
- рассчитывать [ROI](../glossary.md#abbr-073) и [TCO](../glossary.md#abbr-087) внедрения;
- управлять жизненным циклом инструментов и governance-политиками.

## Классы инструментов

- [Инструменты моделирования](modeling-tools.md)
- [Инструменты управления требованиями](requirements-tools.md)
- [Инструменты дизайна и тестирования API](api-tools.md)
- [Инструменты работы с БД](database-tools.md)
- [Инструменты интеграций](integration-tools.md)

## Расширенная матрица выбора

| Класс | Цель | Форматы/методологии | Популярные решения | Лицензия и стоимость | Локализация | Offline/Online | Зрелость внедрения |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Моделирование | [UML](../glossary.md#abbr-092)/[BPMN](../glossary.md#abbr-009)/[C4](../glossary.md#abbr-011)/ArchiMate, визуализация процессов | UML, BPMN, C4, ArchiMate, [ERD](../glossary.md#abbr-032) | PlantUML, Mermaid, draw.io, Lucidchart, Visio, Visual Paradigm, MagicDraw, Enterprise Architect | OSS/free + commercial | обычно EN, частично RU | оба режима | от локальной команды до enterprise |
| Требования | backlog, спецификации, traceability, audit | User Story, Use Case, [BRD](../glossary.md#abbr-010)/[SRS](../glossary.md#abbr-085), ReqIF | Jira+Confluence, Azure DevOps, DOORS Next, Polarion, Jama, ReqView, Aha!, ClickUp | чаще commercial, есть OSS/гибрид | EN, частично RU | cloud/on-prem | высокий эффект в medium/large программах |
| API | contract-first, тесты, документация | OpenAPI 3.1, RAML, GraphQL SDL, Protobuf, WSDL | Swagger, Postman/Newman, SoapUI, Apollo Studio, grpcurl, PACT, Dredd | mixed | EN | cloud/on-prem | высокий эффект при [CI/CD](../glossary.md#abbr-017) |
| Базы данных | проектирование схем, миграции, диагностика | [SQL](../glossary.md#abbr-084), NoSQL schema, migration DSL | DataGrip, DBeaver, pgAdmin, Flyway, Liquibase, Mongo Compass, dbdiagram.io | mixed | EN | desktop + cloud | критично для data-driven систем |
| Интеграции | [ETL](../glossary.md#abbr-033)/[ELT](../glossary.md#abbr-030), брокеры, orchestration, observability | ETL, streaming, EDA, API Mgmt, mesh | Talend, Airflow, dbt, NiFi, Kafka Connect, Kong, Apigee, Kiali, Grafana | mixed | EN | cloud/on-prem | высокий эффект в распределенных системах |

## Методика выбора инструмента

1. Определить целевой артефакт и этап SDLC.
2. Зафиксировать ограничения: security/compliance, лицензии, политики ИБ, data residency.
3. Проверить интеграции с текущим стеком: Git, CI/CD, SSO, Jira/Confluence, test management.
4. Оценить стоимость внедрения: лицензии, обучение, администрирование, миграция данных.
5. Провести пилот на ограниченном scope (2-6 недель).
6. Зафиксировать решение в [ADR](../glossary.md#abbr-003)/decision log и критерии успеха.

## Чек-лист «Быстрый старт»

- назначен владелец инструмента и владелец методики;
- определены шаблоны артефактов;
- настроены роли доступа и аудит;
- подготовлены onboarding-материалы;
- выбран пилотный процесс и baseline-метрики.

## Чек-лист «Внедрение»

- выполнен пилот и собрана обратная связь;
- настроены интеграции с текущим toolchain;
- утверждены политики хранения/архивации;
- зафиксированы [SLA](../glossary.md#abbr-079) поддержки инструмента;
- измерен эффект (скорость, качество, [NPS](../glossary.md#abbr-054) пользователей).

## Связь с жизненным циклом и требованиями

| Этап SDLC | Инструменты |
| --- | --- |
| Сбор и анализ требований | Jira/Confluence, DOORS/Polarion/Jama, Miro/draw.io |
| [Декомпозиция](../glossary.md#term-019) и проектирование | PlantUML/draw.io/EA/MagicDraw, Swagger/AsyncAPI |
| Разработка | Git + CI/CD, contract testing, migrations tools |
| Тестирование | Postman/Newman, SoapUI, PACT, JMeter/k6, OWASP ZAP |
| Внедрение | CI/CD, API gateways, migration pipeline |
| Эксплуатация | Grafana/Prometheus/Kibana/Jaeger, service mesh dashboards |

## Архитектурная зависимость выбора инструментов

- Микросервисы: API gateway, contract testing, observability, CI/CD, schema governance.
- Монолит: важнее сильные SQL/traceability инструменты и упрощенный интеграционный стек.
- Event-driven: критичны Kafka/Pulsar tooling, schema registry, DLQ и trace.
- Регуляторный контур: нужен audit trail, требования к on-prem и строгая рольовая модель.

## Практические recipes

### Recipe 1: EPIC -> Story в Jira

1. Создать Epic с бизнес-целью и [KPI](../glossary.md#abbr-047).
2. Декомпозировать на Stories с [AC](../glossary.md#abbr-002).
3. Привязать тесты и релизную версию.
4. Включить дашборд по aging/blockers.

### Recipe 2: Настройка PlantUML в VS Code

1. Установить расширение `PlantUML`.
2. Подключить рендер через Kroki или локальный сервер.
3. Хранить диаграммы рядом с требованиями в Git.
4. Включить review диаграмм в PR-процесс.

### Recipe 3: Публикация API-документации

1. Описать OpenAPI 3.1 контракт.
2. Проверить lint и backward compatibility.
3. Сгенерировать Swagger [UI](../glossary.md#abbr-091)/Redoc.
4. Опубликовать в developer portal.

### Recipe 4: [Миграция](../glossary.md#term-045) схемы с Liquibase

1. Создать changeset.
2. Прогнать в dev/stage.
3. Проверить rollback.
4. Включить шаг в CI/CD pipeline.

### Recipe 5: Kafka Connect [CDC](../glossary.md#abbr-014) из PostgreSQL

1. Настроить Debezium source connector.
2. Зарегистрировать схемы в Schema Registry.
3. Настроить DLQ/retry topics.
4. Добавить мониторинг lag/error/rebalance.

## Шаблоны артефактов

### OpenAPI 3.1 (минимум)

```yaml
openapi: 3.1.0
info:
  title: Orders API
  version: 1.0.0
paths:
  /orders/{id}:
    get:
      responses:
        '200':
          description: OK
```

### Jira issue template (минимум)

| Поле | Пример |
| --- | --- |
| Business goal | сократить время обработки заявки |
| Acceptance criteria | Given/When/Then |
| Dependencies | [API](../glossary.md#abbr-005) billing v2 |
| Risks | [SLA](../glossary.md#abbr-079) внешней системы |

### Confluence page template (минимум)

| Раздел | Содержание |
| --- | --- |
| Контекст | бизнес-проблема |
| Сценарии | happy/alternative/error |
| Ограничения | [NFR](../glossary.md#abbr-053), регуляторика |
| Связи | Jira/API/диаграммы |

## Метрики выбора и внедрения

| Группа метрик | Примеры |
| --- | --- |
| Обучение | время онбординга, % прошедших обучение |
| Стоимость | лицензии, инфраструктура, поддержка |
| Интеграции | число работающих интеграций, доля ручных операций |
| Качество | снижение дефектов требований/контрактов |
| Скорость | lead time на подготовку артефактов, cycle time изменений |
| [UX](../glossary.md#abbr-093) инструмента | [NPS](../glossary.md#abbr-054) пользователей, частота отказа от использования |

## Пример [ROI](../glossary.md#abbr-073) (open-source vs commercial)

| Сценарий | Open-source стек | Commercial стек |
| --- | --- | --- |
| Небольшая команда (1-2 продукта) | низкая лицензия, выше ручная настройка | быстрее старт, выше стоимость лицензий |
| Средняя программа (3-6 команд) | ниже [TCO](../glossary.md#abbr-087) при сильной экспертизе | выше предсказуемость и support |
| Крупный enterprise | часто сложнее масштабировать без платформенной команды | лучше governance, аудит и SLA поддержки |

## Обновляемость и развитие

- проверяйте release notes инструментов не реже 1 раза в квартал;
- пересматривайте политики безопасности и доступов при крупных обновлениях;
- ведите журнал изменений шаблонов и процесса;
- используйте комьюнити и vendor-академии для онбординга.

## Полезные сообщества и обучающие ресурсы

- Atlassian University: <https://university.atlassian.com/>
- JetBrains Guides: <https://www.jetbrains.com/guide/>
- Postman Learning Center: <https://learning.postman.com/>
- Kong Academy: <https://academy.konghq.com/>
- Confluent Developer: <https://developer.confluent.io/>
