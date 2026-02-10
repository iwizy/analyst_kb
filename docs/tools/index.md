# Инструменты

Раздел собран как практический гид по выбору инструментов системного аналитика. Фокус: не «лучший инструмент вообще», а подходящий инструмент под задачу, контекст команды и ограничения проекта.

## Классы инструментов

- [Инструменты моделирования](modeling-tools.md)
- [Инструменты управления требованиями](requirements-tools.md)
- [Инструменты дизайна и тестирования API](api-tools.md)
- [Инструменты работы с БД](database-tools.md)
- [Инструменты интеграций](integration-tools.md)

## Практическая матрица выбора

| Класс | Популярные инструменты | Когда использовать | Плюсы | Ограничения |
| --- | --- | --- | --- | --- |
| Моделирование | PlantUML, draw.io, Enterprise Architect, Camunda Modeler, Archi | UML/BPMN/C4/ArchiMate и процессные модели | Визуализация и синхронизация понимания | Разный порог входа и лицензирование |
| Требования и knowledge base | Jira, Confluence, Polarion, Jama, DOORS | Backlog, требования, review и traceability | Управляемость изменений и связей | Нужно настроить workflow и дисциплину |
| API | Swagger/OpenAPI, Postman, SoapUI | Контракты API, тестирование интеграций | Быстрый feedback по контрактам | Риск рассинхронизации без governance |
| БД | DataGrip, pgAdmin, DBeaver | Проектирование схем, SQL-анализ, диагностика | Ускорение аналитики и debugging | Нужен контроль доступа к данным |
| Интеграции | Talend, Kafka UI, RabbitMQ UI | ETL/интеграции, мониторинг очередей | Видимость потока данных | Операционная сложность |

## Как выбирать инструмент

1. Зафиксируйте цель артефакта (диаграмма, требование, API-контракт, SQL-анализ).
1. Уточните ограничения (безопасность, лицензии, контур).
1. Проверьте интеграцию с текущим toolchain команды.
1. Оцените стоимость внедрения (обучение, поддержка, администрирование).
1. Выберите минимальный набор, покрывающий процесс end-to-end.

## Быстрый старт по классам

### Моделирование

- [PlantUML](plantuml.md): versioned text-based diagrams;
- [Draw.io](drawio.md): быстрые схемы для встреч;
- [Camunda Modeler](camunda-modeler.md): BPMN ближе к исполнению.

### Требования

- [Jira](jira.md): управление backlog и workflow;
- [Confluence](confluence.md): шаблоны, протоколы, knowledge base.

### API

- [Swagger](swagger.md): контракты и спецификации;
- [Postman](postman.md): коллекции, тесты, smoke-check;
- [SOAP UI](soap-ui.md): legacy/SOAP и интеграционное тестирование.

### Базы данных и интеграции

- [Инструменты работы с БД](database-tools.md)
- [Инструменты интеграций](integration-tools.md)

## Рекомендации по внедрению

- зафиксируйте стандарт артефактов (шаблоны, naming, workflow);
- назначьте владельца инструмента и владельца методики;
- начните с пилота на одном продукте/команде;
- измеряйте эффект: lead time, дефекты требований, время согласования.

## Первоисточники

- PlantUML: <https://plantuml.com/>
- draw.io: <https://www.drawio.com/>
- Jira: <https://www.atlassian.com/software/jira>
- Confluence: <https://www.atlassian.com/software/confluence>
- OpenAPI: <https://spec.openapis.org/oas/latest.html>
- Postman Learning Center: <https://learning.postman.com/>

## Переход к подразделам

- [Инструменты моделирования](modeling-tools.md)
- [Инструменты управления требованиями](requirements-tools.md)
- [Инструменты дизайна и тестирования API](api-tools.md)
- [Инструменты работы с БД](database-tools.md)
- [Инструменты интеграций](integration-tools.md)
- [PlantUML](plantuml.md)
- [Camunda Modeler](camunda-modeler.md)
- [Jira](jira.md)
- [Confluence](confluence.md)
- [Swagger](swagger.md)
- [Postman](postman.md)
- [SOAP UI](soap-ui.md)
- [Figma](figma.md)
- [Draw.io](drawio.md)
- [Консоль браузера](browser-console.md)

## Контрольные вопросы

- Какие 2-3 инструмента действительно нужны для вашего потока, а какие избыточны?
- Где хранится «источник правды» по требованиям и решениям?
- Как связаны диаграммы, требования, API-контракты и тесты?
- Какие метрики покажут, что инструмент повышает эффективность, а не добавляет overhead?
- Кто отвечает за обновление шаблонов и поддержку практики использования инструмента?
