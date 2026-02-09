# Инструменты дизайна и тестирования API

## Популярные решения

| Инструмент | Когда использовать | Плюсы | Минусы |
| --- | --- | --- | --- |
| Swagger/OpenAPI | contract-first дизайн REST API | стандарт де-факто, генерация docs/clients | требуется дисциплина актуализации |
| Postman | ручные и автопроверки API | быстрый старт, коллекции и окружения | риск «локальных» тестов без CI |
| SoapUI | enterprise SOAP/REST тестирование | сильные проверки XML/WSDL | менее удобен для легких REST кейсов |
| Insomnia | легкий API-клиент | простой интерфейс | меньше enterprise-функций |

## Как начать

1. Зафиксируйте API-контракт (OpenAPI/WSDL).
1. Подготовьте тестовые коллекции: happy path + negative.
1. Подключите прогоны к CI (Newman/аналог).
1. Введите версионирование и политику backward compatibility.

## Официальные ресурсы

- OpenAPI Specification: <https://spec.openapis.org/oas/latest.html>
- Swagger: <https://swagger.io/>
- Postman Learning Center: <https://learning.postman.com/>
- SoapUI: <https://www.soapui.org/>
