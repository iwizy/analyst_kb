# Data Governance

Data Governance задает роли, правила и процессы управления данными: качество, доступ, происхождение, соответствие регуляторике.

## Уровни сложности

### Базовый

- определить роли и ответственность (owner, steward, consumer);
- описать минимальные политики доступа и качества.

### Средний

- внедрить каталог метаданных и lineage;
- формализовать data quality controls и классификацию данных.

### Продвинутый

- создать Data Governance Council и operating model;
- встроить governance в SDLC и платформу данных.

## Роли и процессы

| Роль | Ответственность |
| --- | --- |
| Data Governance Council | политика и приоритеты на уровне компании |
| Chief Data Officer | стратегия данных и контроль исполнения |
| Data Owner | бизнес-ответственность за домен |
| Data Steward | качество, словарь, правила, lifecycle |
| Platform/Data Engineer | техническая реализация и lineage |

## Инструменты

- Collibra;
- Alation;
- DataHub (open source);
- OpenLineage для lineage telemetry.

## Базовые политики

- классификация данных (public/internal/confidential/restricted);
- access control (RBAC/ABAC);
- retention and archival policy;
- data quality policy и incident process.

## Кейс: финансовая компания

Контекст:

- несколько источников клиентских данных;
- регуляторные требования к отчетности и аудиту.

Шаги:

1. Создать Governance Council и назначить Data Owners.
2. Внедрить каталог метаданных и lineage по критичным отчетам.
3. Ввести обязательную классификацию PII/финансовых атрибутов.
4. Реализовать RBAC/ABAC и контроль доступа по принципу least privilege.
5. Запустить KPI: completeness, lineage coverage, policy violations.

## Типовые ошибки

- governance как документ, а не как рабочий процесс;
- отсутствие владельцев данных в бизнесе;
- catalog без интеграции в delivery pipeline;
- контроль качества "по запросу", а не непрерывно.

## Практические рекомендации

1. Начинайте с critical data domains и регуляторных отчетов.
2. Интегрируйте governance checks в CI/CD и data pipelines.
3. Делайте lineage обязательным для tier-1 витрин.
4. Регулярно проводите review доступа и policy compliance.

## Контрольные вопросы

1. Кто отвечает за каждую критичную таблицу/витрину?
2. Есть ли сквозной lineage для регуляторных отчетов?
3. Как быстро обнаруживаются и исправляются data quality инциденты?
4. Как проверяется корректность RBAC/ABAC правил?

## Чек-лист самопроверки

- назначены роли governance и ownership;
- каталог и lineage покрывают критичные данные;
- классификация и контроль доступа работают;
- метрики качества данных и compliance измеряются;
- governance встроен в операционный процесс, а не живет отдельно.

## Стандарты и источники

- DAMA-DMBOK: <https://www.dama.org/content/body-knowledge>
- NIST Privacy Framework: <https://www.nist.gov/privacy-framework>
- OpenLineage: <https://openlineage.io/>
- DataHub docs: <https://datahubproject.io/docs/>
