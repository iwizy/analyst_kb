# Карта компетенций

Эта карта помогает увидеть полный набор компетенций аналитика и выбрать направления для развития.

Все знать невозможно: у каждого специалиста своя глубина по темам. Карта нужна как ориентир для поэтапного развития и проверки прогресса.

Статус темы отмечается индикатором:

- `🟢` - тема заполнена базовым материалом и примерами.
- `🔴` - тема в работе и требует дальнейшего наполнения.

## Работа с требованиями 🟢

### Базовый уровень 🟢

- [Работа с требованиями: маршрут по уровням](requirements/index.md) 🟢
- [Определение границ системы](requirements/system-boundaries/index.md) 🟢
  - [Зона ответственности проекта](requirements/system-boundaries/responsibility-zone.md) 🟢
  - [Ограничения](requirements/system-boundaries/constraints.md) 🟢
- [Выявление заинтересованных лиц (стейкхолдеров)](requirements/stakeholders.md) 🟢
- [Уровни требований](requirements/levels/index.md) 🟢
  - [Бизнес-требования](requirements/levels/business.md) 🟢
  - [Пользовательские требования](requirements/levels/user.md) 🟢
  - [Системные требования](requirements/levels/system.md) 🟢
- [Виды требований](requirements/types/index.md) 🟢
  - [Функциональные требования](requirements/types/functional.md) 🟢
  - [Нефункциональные требования](requirements/types/non-functional.md) 🟢
- [Сбор требований](requirements/elicitation.md) 🟢
- [Критерии качества требований](requirements/quality.md) 🟢

### Средний уровень 🟢

- [Подходы к спецификации требований](requirements/specification-approaches.md) 🟢
- [Структурирование требований](requirements/structuring.md) 🟢
- [Декомпозиция требований](requirements/decomposition.md) 🟢
- [Валидация и верификация требований](requirements/validation.md) 🟢
- [Приоритизация требований](requirements/management/prioritization.md) 🟢

### Продвинутый уровень 🟢

- [Управление требованиями](requirements/management/index.md) 🟢
  - [Трассировка требований](requirements/management/traceability.md) 🟢
  - [Поддержка актуальности требований](requirements/management/relevance.md) 🟢
  - [Управление изменениями требований](requirements/management/change-management.md) 🟢
  - [Согласование требований](requirements/management/coordination.md) 🟢

## Базы данных 🟢

- [Типы БД](database/types/index.md) 🟢
  - [Реляционные](database/types/relational.md) 🟢
  - [NewSQL](database/types/newsql.md) 🟢
  - [NoSQL](database/types/nosql/index.md) 🟢
    - [Документоориентированные](database/types/nosql/document.md) 🟢
    - [Ключ-значение](database/types/nosql/key-value.md) 🟢
    - [Колоночные](database/types/nosql/columnar.md) 🟢
    - [Временной ряд](database/types/nosql/time-series.md) 🟢
    - [Графовые](database/types/nosql/graph.md) 🟢
    - [Поисковые](database/types/nosql/search.md) 🟢
- [Консистентность и распределение](database/consistency-and-distribution.md) 🟢
- [Распределённые реестры](database/distributed-ledgers/index.md) 🟢
  - [Blockchain и смарт-контракты](database/distributed-ledgers/blockchain-and-smart-contracts.md) 🟢
- [Проектирование модели данных](database/data-modeling.md) 🟢
- [Нормализация и денормализация](database/normalization/index.md) 🟢
  - [Нормальные формы](database/normalization/normal-forms.md) 🟢
- [SQL](database/sql/index.md) 🟢
  - [Селекты](database/sql/selects.md) 🟢
  - [Агрегатные функции](database/sql/aggregate-functions.md) 🟢
  - [Группировка и сортировка](database/sql/grouping-sorting.md) 🟢
  - [Вложенные запросы](database/sql/subqueries.md) 🟢
  - [Индексы](database/sql/indexes.md) 🟢
  - [Хранимые процедуры и пользовательские функции](database/sql/stored-procedures-and-udf.md) 🟢
  - [Оконные функции](database/sql/window-functions.md) 🟢
- [Масштабирование БД](database/scaling/index.md) 🟢
  - [Партицирование](database/scaling/partitioning.md) 🟢
  - [Шардирование](database/scaling/sharding.md) 🟢
- [DWH и Data Lake](database/dwh-and-data-lake.md) 🟢
- [Master Data Management (MDM)](database/mdm.md) 🟢
- [Data Governance](database/data-governance.md) 🟢
- [Реплицирование данных](database/replication.md) 🟢
- [Бэкапирование данных](database/backup.md) 🟢

## Интеграции 🟢

- [Проектирование API](integrations/api-design/index.md) 🟢
  - [Сущности, атрибуты, контракты](integrations/api-design/entities-attributes-contracts.md) 🟢
  - [Документирование API](integrations/api-design/api-documentation.md) 🟢
  - [Форматы сериализации](integrations/api-design/serialization-formats/index.md) 🟢
    - [JSON](integrations/api-design/serialization-formats/json.md) 🟢
    - [XML / XSD](integrations/api-design/serialization-formats/xml-xsd.md) 🟢
    - [YAML](integrations/api-design/serialization-formats/yaml.md) 🟢
  - [Обратная совместимость](integrations/api-design/backward-compatibility.md) 🟢
  - [Идемпотентность](integrations/api-design/idempotency.md) 🟢
- [Способы интеграции](integrations/integration-methods/index.md) 🟢
  - [API](integrations/integration-methods/api/index.md) 🟢
    - [REST / HTTP(S)](integrations/integration-methods/api/rest-http.md) 🟢
    - [SOAP](integrations/integration-methods/api/soap.md) 🟢
    - [GraphQL](integrations/integration-methods/api/graphql.md) 🟢
    - [gRPC](integrations/integration-methods/api/grpc.md) 🟢
    - [JSON-RPC](integrations/integration-methods/api/json-rpc.md) 🟢
    - [WebSockets](integrations/integration-methods/api/websockets.md) 🟢
  - [Брокеры сообщений](integrations/integration-methods/message-brokers/index.md) 🟢
    - [Kafka](integrations/integration-methods/message-brokers/kafka.md) 🟢
    - [RabbitMQ](integrations/integration-methods/message-brokers/rabbitmq.md) 🟢
  - [Общая БД](integrations/integration-methods/shared-database.md) 🟢
  - [Обмен файлами](integrations/integration-methods/file-exchange.md) 🟢
- [Сетевое взаимодействие](integrations/networking/index.md) 🟢
  - [Модель OSI](integrations/networking/osi.md) 🟢
  - [TCP/IP](integrations/networking/tcp-ip.md) 🟢
  - [UDP](integrations/networking/udp.md) 🟢
  - [Сокеты](integrations/networking/sockets.md) 🟢

## Нотации, диаграммы, моделирование 🟢

- [UML](notations/uml/index.md) 🟢
  - [Sequence](notations/uml/sequence.md) 🟢
  - [Activity](notations/uml/activity.md) 🟢
  - [Class](notations/uml/class.md) 🟢
  - [State Machine](notations/uml/state-machine.md) 🟢
- [BPMN](notations/bpmn.md) 🟢
- [C4](notations/c4.md) 🟢
- [ERD](notations/erd.md) 🟢
- [DFD](notations/dfd.md) 🟢
- [eEPC](notations/eepc.md) 🟢
- [IDEF0](notations/idef0.md) 🟢
- [Archimate](notations/archimate.md) 🟢
- [Диаграмма Исикавы](notations/fishbone-diagram.md) 🟢
- [Деревья решений](notations/decision-trees.md) 🟢
- [Карта целей](notations/goals-map.md) 🟢
- [Impact Map](notations/impact-map.md) 🟢
- [Модели зрелости](notations/maturity-models/index.md) 🟢
  - [CMMI](notations/maturity-models/cmmi.md) 🟢
  - [COBIT](notations/maturity-models/cobit.md) 🟢
  - [ACMM](notations/maturity-models/acmm.md) 🟢

## Алгоритмы 🟢

- [Типовые алгоритмы](algorithms/typical/index.md) 🟢
  - [Алгоритмы сортировки](algorithms/typical/sorting.md) 🟢
  - [Теория графов и бинарные деревья](algorithms/typical/graphs-and-binary-trees.md) 🟢
  - [Рекурсия](algorithms/typical/recursion.md) 🟢
  - [Циклы](algorithms/typical/loops.md) 🟢
- [Области использования алгоритмов и структур данных](algorithms/usage-areas.md) 🟢
- [Сложность алгоритмов и O-нотация](algorithms/complexity-big-o.md) 🟢

## Проектирование и архитектура 🟢

- [Архитектура информационных систем](architecture/systems-architecture/index.md) 🟢
  - [Виды архитектур](architecture/systems-architecture/architecture-types/index.md) 🟢
    - [Клиент-серверная архитектура](architecture/systems-architecture/architecture-types/client-server.md) 🟢
    - [Монолитная архитектура](architecture/systems-architecture/architecture-types/monolith.md) 🟢
    - [Микросервисная архитектура](architecture/systems-architecture/architecture-types/microservices.md) 🟢
    - [Модульный монолит](architecture/systems-architecture/architecture-types/modular-monolith.md) 🟢
    - [Многослойная архитектура](architecture/systems-architecture/architecture-types/multilayer.md) 🟢
    - [SOA](architecture/systems-architecture/architecture-types/soa.md) 🟢
    - [Микрофронтенды](architecture/systems-architecture/architecture-types/microfrontends.md) 🟢
    - [MVC, MVP, MVVM](architecture/systems-architecture/architecture-types/mvc-mvp-mvvm.md) 🟢
    - [Peer-to-peer](architecture/systems-architecture/architecture-types/p2p.md) 🟢
  - [Архитектурные паттерны и антипаттерны](architecture/systems-architecture/patterns-antipatterns.md) 🟢
  - [Синхронное и асинхронное взаимодействие](architecture/systems-architecture/sync-async.md) 🟢
  - [Кэширование](architecture/systems-architecture/caching.md) 🟢
  - [Оркестрация и хореография](architecture/systems-architecture/orchestration-choreography.md) 🟢
  - [Масштабирование сервисов](architecture/systems-architecture/service-scaling.md) 🟢
  - [Контейнеризация](architecture/systems-architecture/containerization.md) 🟢
  - [Мониторинг и поддержка](architecture/systems-architecture/monitoring-support.md) 🟢
  - [Облачные вычисления](architecture/systems-architecture/cloud-computing.md) 🟢
- [Подходы к проектированию](architecture/design-approaches/index.md) 🟢
  - [Объектно-ориентированное проектирование](architecture/design-approaches/oop-design/index.md) 🟢
    - [DDD](architecture/design-approaches/oop-design/ddd.md) 🟢
    - [Event Storming](architecture/design-approaches/oop-design/event-storming.md) 🟢
  - [Функциональное (структурное) проектирование](architecture/design-approaches/functional-design.md) 🟢
- [Декомпозиция задач](architecture/task-decomposition.md) 🟢
- [Архитектура предприятия](architecture/enterprise-architecture/index.md) 🟢
  - [TOGAF](architecture/enterprise-architecture/togaf.md) 🟢
  - [Zachman](architecture/enterprise-architecture/zachman.md) 🟢
  - [FEAF](architecture/enterprise-architecture/feaf.md) 🟢
  - [DODAF](architecture/enterprise-architecture/dodaf.md) 🟢
- [Пользовательский интерфейс (UI/UX)](architecture/ui-ux/index.md) 🟢
  - [Основы UI/UX](architecture/ui-ux/basics.md) 🟢
  - [Прототипирование](architecture/ui-ux/prototyping.md) 🟢
  - [Customer Journey Map](architecture/ui-ux/customer-journey-map.md) 🟢
- [Информационная безопасность](architecture/information-security/index.md) 🟢
  - [Способы обеспечения ИБ](architecture/information-security/security-methods.md) 🟢
  - [Авторизация и аутентификация](architecture/information-security/authorization-authentication.md) 🟢
  - [Хеширование и шифрование](architecture/information-security/hashing-encryption.md) 🟢
  - [Основы криптографии](architecture/information-security/cryptography-basics.md) 🟢
  - [SSL / TLS](architecture/information-security/ssl-tls.md) 🟢
  - [Электронная подпись](architecture/information-security/digital-signature.md) 🟢
  - [Основные уязвимости веб-сервисов и приложений](architecture/information-security/common-web-vulnerabilities.md) 🟢

## Процесс разработки 🟢

- [Жизненный цикл программного продукта](development-process/product-lifecycle/index.md) 🟢
  - [Этапы жизненного цикла ПО](development-process/product-lifecycle/stages.md) 🟢
  - [Основы DevOps](development-process/product-lifecycle/devops-basics.md) 🟢
  - [Основы CI/CD](development-process/product-lifecycle/cicd-basics.md) 🟢
  - [Git](development-process/product-lifecycle/git.md) 🟢
- [Сопровождение функциональности](development-process/feature-support/index.md) 🟢
  - [Мониторинг и логирование](development-process/feature-support/monitoring-logging.md) 🟢
  - [Разбор инцидентов](development-process/feature-support/incident-analysis.md) 🟢
  - [Основы SRE](development-process/feature-support/sre-basics.md) 🟢
- [Основы программирования](development-process/programming-basics/index.md) 🟢
  - [ООП](development-process/programming-basics/oop.md) 🟢
  - [Чтение кода](development-process/programming-basics/code-reading.md) 🟢
  - [Написание кода](development-process/programming-basics/coding.md) 🟢
- [Тестирование](development-process/testing/index.md) 🟢
  - [Приемка функциональности](development-process/testing/acceptance-testing.md) 🟢
  - [Тест-кейсы](development-process/testing/test-cases.md) 🟢
  - [Ручное тестирование](development-process/testing/manual-testing.md) 🟢

## Методологии разработки ПО 🟢

- [Waterfall](methodologies/waterfall/index.md) 🟢
  - [V-образная](methodologies/waterfall/v-model.md) 🟢
  - [Инкрементная](methodologies/waterfall/incremental.md) 🟢
  - [Спиральная](methodologies/waterfall/spiral.md) 🟢
- [Agile](methodologies/agile.md) 🟢
- [Методологии и фреймворки](methodologies/frameworks/index.md) 🟢
  - [Scrum](methodologies/frameworks/scrum.md) 🟢
  - [Lean](methodologies/frameworks/lean.md) 🟢
  - [XP](methodologies/frameworks/xp.md) 🟢
  - [RUP](methodologies/frameworks/rup.md) 🟢
  - [Kanban](methodologies/frameworks/kanban.md) 🟢
  - [LeSS](methodologies/frameworks/less.md) 🟢
  - [PDCA](methodologies/frameworks/pdca.md) 🟢

## Инструменты 🟢

- [PlantUML](tools/plantuml.md) 🟢
- [Camunda Modeler](tools/camunda-modeler.md) 🟢
- [Jira](tools/jira.md) 🟢
- [Confluence](tools/confluence.md) 🟢
- [Swagger](tools/swagger.md) 🟢
- [Postman](tools/postman.md) 🟢
- [SOAP UI](tools/soap-ui.md) 🟢
- [Figma](tools/figma.md) 🟢
- [Draw.io](tools/drawio.md) 🟢
- [Консоль браузера](tools/browser-console.md) 🟢

## Общие компетенции 🟢

- [Оценка задач и рисков](common-competencies/estimation-risks/index.md) 🟢
  - [Оценка трудоемкости](common-competencies/estimation-risks/effort-estimation.md) 🟢
  - [Выявление рисков](common-competencies/estimation-risks/risk-identification.md) 🟢
  - [Управление рисками](common-competencies/estimation-risks/risk-management.md) 🟢
- [Стандарты и своды знаний](common-competencies/standards/index.md) 🟢
  - [BABOK](common-competencies/standards/babok.md) 🟢
  - [SEBOK](common-competencies/standards/sebok.md) 🟢
  - [DAMA DMBOK](common-competencies/standards/dama-dmbok.md) 🟢
  - [ITIL](common-competencies/standards/itil.md) 🟢
  - [COBIT](common-competencies/standards/cobit.md) 🟢
  - [CBAP](common-competencies/standards/cbap.md) 🟢
  - [CPRE](common-competencies/standards/cpre.md) 🟢
  - [ГОСТ 19](common-competencies/standards/gost-19.md) 🟢
  - [ГОСТ 34](common-competencies/standards/gost-34.md) 🟢
  - [PMBOK](common-competencies/standards/pmbok.md) 🟢
  - [ISO 12207](common-competencies/standards/iso-12207.md) 🟢
  - [ISO 15288](common-competencies/standards/iso-15288.md) 🟢
  - [IEEE](common-competencies/standards/ieee.md) 🟢
  - [ARIS](common-competencies/standards/aris.md) 🟢
- [Техники](common-competencies/techniques/index.md) 🟢
  - [SWOT](common-competencies/techniques/swot.md) 🟢
  - [5 Why](common-competencies/techniques/five-why.md) 🟢
  - [Mind Map](common-competencies/techniques/mind-map.md) 🟢

## Смежные навыки 🟢

- [Анализ данных](related-skills/data-analysis/index.md) 🟢
  - [DWH](related-skills/data-analysis/dwh.md) 🟢
  - [OLTP](related-skills/data-analysis/oltp.md) 🟢
  - [OLAP](related-skills/data-analysis/olap.md) 🟢
  - [ETL / ELT](related-skills/data-analysis/etl-elt.md) 🟢
  - [Data Science](related-skills/data-analysis/data-science.md) 🟢
  - [Инструменты анализа данных](related-skills/data-analysis/tools/index.md) 🟢
    - [Tableau](related-skills/data-analysis/tools/tableau.md) 🟢
    - [QlikView](related-skills/data-analysis/tools/qlikview.md) 🟢
    - [Power BI](related-skills/data-analysis/tools/power-bi.md) 🟢
- [Управление продуктом](related-skills/product-management.md) 🟢
- [Экономика и финансы](related-skills/economics-finance/index.md) 🟢
  - [TCO](related-skills/economics-finance/tco.md) 🟢
  - [ROI, NPV, IRR](related-skills/economics-finance/roi-npv-irr.md) 🟢
- [Управление проектами](related-skills/project-management.md) 🟢
- [Промпт-инжиниринг](related-skills/prompt-engineering.md) 🟢

## Софт-скилы 🟢

- [Коммуникативные навыки](soft-skills/communication/index.md) 🟢
  - [Ведение переговоров](soft-skills/communication/negotiation.md) 🟢
  - [Ведение переписки](soft-skills/communication/correspondence.md) 🟢
  - [Умение общаться](soft-skills/communication/communication.md) 🟢
  - [Проведение презентаций](soft-skills/communication/presentations.md) 🟢
  - [Фасилитация встреч](soft-skills/communication/facilitation.md) 🟢
  - [Эмоциональный интеллект](soft-skills/communication/emotional-intelligence.md) 🟢
  - [Участие в коммьюнити](soft-skills/communication/community.md) 🟢
  - [Грамотность](soft-skills/communication/literacy.md) 🟢
- [Тайм-менеджмент](soft-skills/time-management.md) 🟢
- [Управление ожиданиями заказчика](soft-skills/expectation-management.md) 🟢
- [Работа в команде](soft-skills/teamwork.md) 🟢
- [Личностные качества](soft-skills/qualities/index.md) 🟢
  - [Аналитическое мышление](soft-skills/qualities/analytical-thinking.md) 🟢
  - [Адаптивность](soft-skills/qualities/adaptability.md) 🟢
  - [Проактивность](soft-skills/qualities/proactivity.md) 🟢
  - [Ответственность](soft-skills/qualities/responsibility.md) 🟢
  - [Общительность](soft-skills/qualities/sociability.md) 🟢
  - [Обучаемость](soft-skills/qualities/learnability.md) 🟢
  - [Критическое мышление](soft-skills/qualities/critical-thinking.md) 🟢
