# YAML

YAML чаще используется для конфигураций, [IaC](../../../glossary.md#abbr-039) и pipeline-описаний, но реже как формат бизнес-payload в публичных [API](../../../glossary.md#abbr-005).

## Уровни сложности

### Базовый уровень

- понимать структуру YAML и правила отступов;
- уметь переводить YAML в JSON;
- применять YAML для конфигураций API и инфраструктуры.

### Средний уровень

- использовать YAML для OpenAPI/AsyncAPI спецификаций;
- валидировать схемы и lint-правила;
- контролировать совместимость конфигураций между средами.

### Продвинутый уровень

- выстраивать governance по конфигурациям (policy as code);
- управлять large-scale репозиториями YAML и drift detection;
- автоматизировать rollout с безопасными guardrails.

## Пример YAML

```yaml
service:
  name: payments-api
  version: 2.1.0
limits:
  per_minute: 600
  burst: 120
security:
  oauth_scopes:
    - payments.read
    - payments.write
```

## Где YAML уместен

| Сценарий | Комментарий |
| --- | --- |
| OpenAPI/AsyncAPI файл | удобен для человеко-читаемого контракта |
| [[CI](../../../glossary.md#abbr-016)/CD](../../../glossary.md#abbr-017) pipeline | основной формат в GitOps-практиках |
| Kubernetes манифесты | стандарт де-факто |
| Бизнес payload [API](../../../glossary.md#abbr-005) | обычно лучше JSON/XML |

## Риски YAML

- чувствительность к отступам и переносам;
- неочевидные типы (`yes/no`, даты, числа);
- риск неявной интерпретации парсерами разных языков.

## Рекомендации

- фиксируйте стиль и линтер (`yamllint`);
- для строгих контрактов используйте schema validation;
- избегайте сложных alias/anchor в критичных конфигурациях;
- храните конфигурации как code с PR-review.
## Стандарты и источники

- YAML specification: <https://yaml.org/spec/1.2.2/>
- OpenAPI in YAML: <https://spec.openapis.org/oas/latest.html>
- AsyncAPI: <https://www.asyncapi.com/docs/reference/specification/latest>
