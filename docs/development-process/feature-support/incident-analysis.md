# Разбор инцидентов

Разбор инцидентов (postmortem) нужен для устранения первопричин и предотвращения повторов. Цель - улучшать систему, а не искать виноватых.

## Уровни сложности

### Базовый уровень

- фиксировать факты и влияние инцидента;
- восстанавливать таймлайн;
- формулировать корректирующие действия.

### Средний уровень

- применять [RCA](../../glossary.md#abbr-070)-методы (5 Why, Fishbone);
- разделять symptoms, causes и contributing factors;
- связывать результаты postmortem с backlog и change management.

### Продвинутый уровень

- использовать error budget и [SLO](../../glossary.md#abbr-081) для приоритизации мер;
- проводить incident trend analysis;
- управлять reliability roadmap на квартал.

## Процесс разбора инцидента

```kroki-plantuml
skinparam monochrome true
start
:Собрать факты и impact;
:Построить таймлайн;
:Провести RCA;
:Определить corrective/preventive actions;
:Назначить владельцев и сроки;
:Проверить выполнение и эффект;
stop
```

## Шаблон postmortem

| Поле | Что фиксировать |
| --- | --- |
| Incident ID | ссылка на инцидент |
| Влияние | пользователи, деньги, [SLA](../../glossary.md#abbr-079) |
| Таймлайн | обнаружение, эскалация, восстановление |
| Первопричина | техническая/процессная |
| Усиливающие факторы | мониторинг, архитектура, коммуникация |
| Действия | corrective/preventive, owner, due date |
| Проверка эффекта | метрика и дата ревью |

## Пример [RCA](../../glossary.md#abbr-070) (кратко)

- Симптом: рост 5xx в сервисе заказов.
- Причина: деградация внешнего [API](../../glossary.md#abbr-005) платежей.
- Почему impact высокий: не настроен fallback и circuit breaker.
- Действие: добавить circuit breaker, cache для статусов, пересмотреть timeout budget.

## Типичные ошибки

- «человеческий фактор» как финальный вывод без анализа системы;
- actions без владельца и срока;
- закрытие postmortem без проверки результата.

## Связь с backlog и техдолгом

После postmortem задачи распределяются на:

- срочные reliability-fixes;
- архитектурные улучшения;
- процессные изменения (мониторинг, runbook, эскалация);
- обучение команды и обновление документации.## Стандарты и источники

- Google SRE (postmortem culture): <https://sre.google/sre-book/postmortem-culture/>
- NIST SP 800-61: <https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final>
- [ITIL](../../glossary.md#abbr-044) 4 Incident/Problem practices: <https://www.axelos.com/>
