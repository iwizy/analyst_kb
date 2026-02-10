# Основы SRE

SRE (Site Reliability Engineering) - инженерный подход к эксплуатации, где надежность управляется метриками, автоматизацией и error budget.

## Уровни сложности

### Базовый уровень

- понимать SLI/SLO/SLA;
- считать error budget;
- использовать базовые runbook и on-call практики.

### Средний уровень

- строить SLO для ключевых пользовательских сценариев;
- применять error budget в релизных решениях;
- автоматизировать рутинные операционные задачи.

### Продвинутый уровень

- проектировать reliability roadmap;
- балансировать delivery speed и stability;
- применять chaos-практики и геймдни.

## SRE-контур принятия решений

```kroki-plantuml
skinparam monochrome true
start
:Измерить SLI;
:Сравнить с SLO;
if (Error budget в норме?) then (Да)
  :Плановые релизы и развитие;
else (Нет)
  :Ограничить feature-релизы;
  :Сфокусироваться на reliability work;
endif
stop
```

## Пример SLI/SLO

| Сценарий | SLI | SLO |
| --- | --- | --- |
| Оформление заказа | доля успешных операций | >= 99.9% за 30 дней |
| API оплаты | p95 latency | <= 350 мс |
| Доступность checkout | uptime | >= 99.95% |

## Базовые SRE-практики

- alerting от SLO, а не от отдельных серверных метрик;
- runbook на каждый критичный алерт;
- blameless postmortem;
- автоматизация repetitive tasks;
- capacity planning и error-budget policy.

## Типовые ошибки

- SLO без согласования с бизнесом;
- слишком много SLI без операционной ценности;
- ручные операции в критичном recovery-контуре.## Стандарты и источники

- Google SRE: <https://sre.google/books/>
- SRE Workbook: <https://sre.google/workbook/>
- OpenSLO: <https://openslo.com/>
