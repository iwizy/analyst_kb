# Инструменты дизайна и тестирования API

Раздел структурирован по этапам API lifecycle: проектирование, документирование, тестирование, мониторинг и эксплуатация.

## Уровни сложности

### Базовый уровень

- выбрать формат контракта (OpenAPI/RAML/GraphQL/gRPC);
- описать API и подготовить примеры запросов/ответов;
- выполнить базовые функциональные проверки.

### Средний уровень

- внедрить contract-first workflow в PR;
- автоматизировать regression/contract/security тесты;
- публиковать и версионировать API-документацию.

### Продвинутый уровень

- контролировать backward compatibility автоматически;
- управлять SDK generation и developer portal;
- выстраивать полноценный API quality gate в CI/CD.

## Категории инструментов

| Категория | Инструменты | Назначение |
| --- | --- | --- |
| Проектирование контракта | Swagger Editor, Stoplight, RAML tools, Apollo Studio, protobuf tools | contract-first спецификация |
| Документирование | Swagger UI, Redocly, Stoplight, GraphiQL | публикация документации и onboarding потребителей |
| Функциональное тестирование | Postman/Newman, SoapUI, grpcurl, Evans, GraphQL mock server | проверка сценариев API |
| Тестирование WebSocket | websocat, Socket.IO client, k6/ws | проверка realtime-каналов и reconnect логики |
| Контрактное тестирование | PACT, Dredd, OpenAPI diff/lint | совместимость и соответствие контракту |
| Нагрузочное тестирование | JMeter, k6, Gatling | performance и SLA |
| Безопасность API | OWASP ZAP, Burp Suite | security scanning и hardening |
| Мониторинг API | Prometheus/Grafana, APIM dashboards, synthetic checks | эксплуатационные метрики |

## Форматы контрактов и поддержка

| Формат | Что описывает | Инструменты |
| --- | --- | --- |
| OpenAPI 3.1 | REST API | Swagger, Stoplight, Redocly, Dredd |
| RAML | REST API (design-first) | Anypoint Platform, RAML tooling |
| GraphQL SDL | GraphQL schema | Apollo Studio, GraphiQL |
| gRPC / Protobuf | RPC-контракты и сообщения | protoc, grpcurl, Evans |
| SOAP/WSDL/XSD | SOAP-контракты | SoapUI, WSDL tools |

## Практические сценарии

### Contract-first с OpenAPI

1. Описать контракт в Swagger Editor.
2. Провести review в pull request.
3. Прогнать lint и compatibility checks.
4. Сгенерировать server/client SDK.
5. Опубликовать docs на Swagger UI/portal.

### Postman + Newman в CI

```bash
newman run collections/orders.postman_collection.json \
  -e envs/stage.postman_environment.json
```

### SoapUI + Jenkins

- импорт WSDL;
- запуск TestSuite в CI job;
- публикация отчета по assertions.

### gRPC smoke

```bash
grpcurl -plaintext localhost:9090 list
grpcurl -plaintext -d '{"id":"1001"}' localhost:9090 order.OrderService/GetOrder
```

## Workflow API (рекомендуемый)

```kroki-plantuml
skinparam monochrome true
start
:Contract-first спецификация;
:PR review и линтеры;
:Генерация SDK/стабов;
:Functional + contract tests;
:Security + load tests;
:Публикация docs в portal;
:Мониторинг и обратная связь;
stop
```

## Совместимость и контроль изменений

- semver policy (major/minor/patch);
- автоматические diff проверки (OpenAPI/GraphQL schema);
- migration guide для breaking changes;
- sunset policy и deprecation headers.

## Кросс-ссылки

- [Интеграции: Проектирование API](../integrations/api-design/index.md)
- [Интеграции: Версионирование API](../integrations/api-design/versioning.md)
- [Процесс разработки: CI/CD](../development-process/product-lifecycle/cicd-basics.md)
- [Требования: Подходы к спецификации](../requirements/specification-approaches.md)

## Связь с требованиями и SDLC

- анализ: контракт фиксирует требования к данным и операциям;
- проектирование: API contract = архитектурный артефакт;
- тестирование: API тесты привязаны к AC/NFR;
- эксплуатация: observability по endpoint latency/error rate.

## Типичные ошибки

- спецификация отстает от фактической реализации;
- отсутствие негативных и security сценариев;
- нет проверки обратной совместимости;
- публикация API без примеров и migration notes.

## Чек-лист самопроверки

- выбран и формализован формат контракта;
- contract review встроен в PR-процесс;
- тесты (functional/contract/security/load) автоматизированы;
- документация API публикуется и версионируется;
- изменение API сопровождается policy backward compatibility.

## Источники

- OpenAPI Spec: <https://spec.openapis.org/oas/latest.html>
- Swagger: <https://swagger.io/>
- Postman: <https://learning.postman.com/>
- SoapUI: <https://www.soapui.org/>
- GraphQL: <https://graphql.org/learn/>
- Apollo Studio: <https://www.apollographql.com/studio>
- gRPC: <https://grpc.io/docs/>
- PACT: <https://docs.pact.io/>
- OWASP ZAP: <https://www.zaproxy.org/>

## Актуализация

- пересматривайте стек инструментов и плагины при каждом крупном обновлении API-платформы;
- проверяйте release notes ключевых инструментов не реже 1 раза в квартал.
