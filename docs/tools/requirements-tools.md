# Инструменты управления требованиями

Раздел описывает практический стек для ведения требований, трассировки, согласования и контроля изменений в Agile и Waterfall контуре.

## Уровни сложности

### Базовый уровень

- вести требования в едином формате;
- связывать задачи с документацией;
- использовать базовую трассировку до тестов.

### Средний уровень

- настраивать workflow и обязательные атрибуты;
- управлять версиями, правами доступа и аудитом;
- строить отчеты по coverage и change impact.

### Продвинутый уровень

- внедрять enterprise traceability end-to-end;
- интегрировать requirements management в DevOps pipeline;
- управлять миграцией между платформами.

## Сравнение решений

| Инструмент | Traceability | Workflow customization | Версионирование | Интеграция с тестами | Аналитика/отчеты | Когда использовать |
| --- | --- | --- | --- | --- | --- | --- |
| Jira + Confluence | высокая при правильной схеме ссылок | высокая | история задач и страниц | Xray/Zephyr/TestRail | дашборды + JQL | продуктовые и enterprise команды |
| IBM DOORS Next | очень высокая | высокая | строгая конфигурация | через инженерный стек IBM | enterprise отчеты | safety/regulatory проекты |
| Polarion | очень высокая | высокая | baseline и variants | встроенные ALM-связи | сильная трассировка | промышленность, automotive |
| Jama Connect | очень высокая | средняя/высокая | версии и reviews | test links, coverage | impact/coverage отчеты | медтех, hardware/software |
| Azure DevOps | высокая | высокая | repos + boards | Test Plans | Power BI | Microsoft-экосистема |
| ReqView (ReqIF) | средняя/высокая | средняя | версии проекта | экспорт/импорт связей | базовые отчеты | обмен требованиями между сторонами |
| Git-based (Markdown + PR) | зависит от дисциплины | высокая через шаблоны | сильная (Git) | через CI/testing links | кастомная | engineering-first команды |
| Aha! | средняя | средняя | roadmap versions | через интеграции | product analytics | продуктовый roadmap |
| ClickUp | средняя | высокая | task-level history | через интеграции | dashboard | SMB/стартапы |

## Практический сценарий end-to-end

1. Confluence: создать спецификацию по шаблону (контекст, сценарии, AC, NFR).
2. Jira: завести Epic -> Story, связать с Confluence страницей.
3. Тесты: связать Story с test case (например, Xray).
4. RTM: сформировать отчет coverage `Requirement -> Task -> Test`.
5. Обмен: экспортировать требования в ReqIF для внешнего подрядчика.
6. Миграция: при переходе DOORS -> Jama сохранить IDs, baseline и mapping атрибутов.

## Best practices

### Шаблоны и атрибуты

Минимальные поля requirement-объекта:

- ID;
- тип (BR/UR/SR/NFR);
- источник;
- бизнес-ценность;
- acceptance criteria;
- статус;
- владелец;
- link to tests/release.

### Стратегии хранения

| Подход | Плюсы | Риски |
| --- | --- | --- |
| Монорепо документации | единый источник правды | сложность прав доступа |
| Распределенные хранилища | гибкость команд | риск дублирования и рассинхрона |

### Права и аудит

- role-based access;
- обязательные reviews для critical требований;
- журнал baseline/change decisions;
- регулярный audit completeness/traceability.

### Автоматическая проверка качества

- шаблоны полей и валидации обязательных атрибутов;
- CI-проверки markdown/ссылок;
- отчеты orphan requirements и stale requirements.

## Agile vs Waterfall поддержка

| Контекст | Как работать в инструменте |
| --- | --- |
| Agile | Epic/Story/Task + AC + refinement history |
| Waterfall | BRD/SRS baseline + formal CR + approval workflow |
| Hybrid | baseline для critical scope + итеративный backlog delivery |

## Интеграция с DevOps pipeline

- requirement ID в PR и commit;
- link to automated tests;
- release notes по связанным требованиям;
- quality gate: без связанного requirement/test релиз блокируется.

## Связь с SDLC и архитектурой

- анализ: repository требований + stakeholder comments;
- дизайн: linkage к C4/UML/API contracts;
- реализация: задачи и PR связаны с requirement IDs;
- тестирование: coverage от требований до test cases;
- эксплуатация: изменения и инциденты возвращаются в requirement backlog.

## Зависимость от методологии

- Agile: story-centric workflow, быстрый refinement, связь с sprint cadence.
- Waterfall: baseline-документы, формальные approvals и CR lifecycle.
- Hybrid: критичный scope фиксируется формально, delivery ведется через backlog.

## Кросс-ссылки

- [Требования](../requirements/index.md)
- [Процесс разработки](../development-process/index.md)
- [Методологии разработки](../methodologies/index.md)

## Типичные ошибки

- слишком много кастомных статусов без смысла;
- отсутствие единого идентификатора требования;
- хранение решений в комментариях, а не в спецификации;
- миграция между системами без mapping атрибутов.

## Чек-лист самопроверки

- настроены шаблоны и обязательные поля;
- есть двусторонняя трассировка;
- права и аудит соответствуют политике организации;
- процесс поддерживает и Agile, и Waterfall сценарии.

## Источники

- Jira: <https://www.atlassian.com/software/jira>
- Confluence: <https://www.atlassian.com/software/confluence>
- IBM DOORS Next: <https://www.ibm.com/products/engineering-requirements-management-doors-next>
- Polarion: <https://polarion.plm.automation.siemens.com/>
- Jama: <https://www.jamasoftware.com/>
- Azure DevOps: <https://learn.microsoft.com/azure/devops/>
- ReqIF standard (OMG): <https://www.omg.org/spec/ReqIF/>

## Актуализация

- пересматривайте шаблоны полей и workflow не реже 1 раза в квартал;
- обновляйте интеграции с test management и CI/CD после крупных релизов платформ.
