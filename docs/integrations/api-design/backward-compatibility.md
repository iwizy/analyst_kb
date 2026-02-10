# Обратная совместимость

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Обратная совместимость снижает операционный риск и стоимость интеграции: клиентам не нужно срочно переписывать код после каждого релиза API.

## Уровни сложности

### Базовый уровень

- различать breaking и non-breaking изменения;
- использовать политику deprecation;
- избегать удаления и изменения типов полей.

### Средний уровень

- автоматизировать compatibility checks;
- поддерживать staging с реальными consumer-контрактами;
- публиковать migration guide.

### Продвинутый уровень

- управлять миграциями через canary/blue-green;
- применять graceful degradation и fallback;
- контролировать совместимость SDK, UI и партнерских клиентов.

## Классификация изменений

| Тип изменения | Класс | Пример |
| --- | --- | --- |
| Добавление необязательного поля | non-breaking | `discountCode?: string` |
| Расширение enum новым значением | условно non-breaking | требует tolerant parser у клиента |
| Удаление поля | breaking | убрать `paymentStatus` |
| Изменение типа | breaking | `amount: string` -> `amount: object` |
| Новый endpoint | non-breaking | `/v1/orders/{id}/history` |

## Влияние на SDK и UI

- SDK: breaking-change ведет к compile/runtime ошибкам и росту инцидентов.
- UI: изменение семантики ответов без фичефлага ломает пользовательские сценарии.
- Партнеры: если нет migration guide, растет time-to-recover и стоимость поддержки.

## Процесс контроля совместимости

1. PR на контракт проходит automatic diff.
2. Для breaking-change нужен explicit approval архитектурного review.
3. Генерируется migration guide и deprecation notice.
4. Проводится тест в совместимом staging окружении.
5. Релиз идет через canary и мониторинг ошибок клиентов.

## Blue/Green, Canary, Rollback

```kroki-plantuml
@startuml
start
:Release Green version;
:Route 10pct traffic to Green;
if (Errors within threshold?) then (yes)
  :Increase to 50pct and 100pct;
  :Sunset Blue;
else (no)
  :Rollback to Blue;
  :Open incident and patch;
endif
stop
@enduml
```

## Артефакты процесса

- Compatibility report (до и после релиза);
- Migration guide с примерами кода;
- Sunset policy и коммуникационный план;
- Контрольный список rollback readiness.

## Типичные ошибки

- изменения по принципу "починим клиентов позже";
- отсутствие версии схемы в событиях;
- неверный парсинг неизвестных enum у клиентов;
- неучтенные внешние интеграции при тестировании.
## Стандарты и источники

- OpenAPI backward compatibility practices: <https://learn.openapis.org/specification/servers.html>
- RFC 9110 HTTP Semantics: <https://www.rfc-editor.org/rfc/rfc9110>
- Google API Improvement Proposals: <https://google.aip.dev/>
