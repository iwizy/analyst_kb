# Принятие решений на основе данных
Data-driven подход помогает заменять предположения проверяемыми гипотезами и уменьшать стоимость ошибочных управленческих решений.

## Уровни сложности

### Базовый уровень

- формулировать гипотезу и метрику успеха;
- различать [KPI](../glossary.md#abbr-047), [OKR](../glossary.md#abbr-058) и операционные метрики;
- отличать полезные и vanity-метрики.

### Средний уровень

- применять [A/B](../glossary.md#abbr-001) тесты и cohort-анализ;
- строить дашборды и decision log;
- учитывать leading и lagging индикаторы.

### Продвинутый уровень

- применять causal impact и статистическую валидацию;
- внедрять регулярные data retrospectives;
- связывать продуктовые метрики с финансовыми и риск-метриками.

## Цикл data-driven решения

```kroki-plantuml
skinparam monochrome true
start
:Гипотеза и цель;
:Выбор метрик и источников;
:Сбор и очистка данных;
:Анализ и визуализация;
:Решение и action plan;
:Проверка эффекта;
if (Эффект достигнут?) then (Да)
  :Масштабировать;
else (Нет)
  :Скорректировать гипотезу;
endif
stop
```

## Типы метрик

| Категория | Примеры |
| --- | --- |
| [KPI](../glossary.md#abbr-047) | доход, [SLA](../glossary.md#abbr-079), доля успешных операций |
| [OKR](../glossary.md#abbr-058) | objective + key results |
| Funnel metrics | conversion между шагами |
| Retention | D1/D7/D30 retention |
| Product quality | defect rate, [MTTR](../glossary.md#abbr-051) |
| Клиентские | [NPS](../glossary.md#abbr-054), CSAT |

## Leading vs Lagging

- Leading indicators: сигналы, предсказывающие результат (например, активация функции).
- Lagging indicators: итоговые показатели (например, квартальная выручка).

## Vanity vs Actionable

- Vanity: «красивые» числа без управленческого действия;
- Actionable: метрики, которые можно улучшать конкретными изменениями.

## Методы проверки гипотез

- [A/B](../glossary.md#abbr-001)-тесты;
- cohort analysis;
- causal impact analysis;
- pre/post анализ с учетом сезонности.

## Инструменты анализа

- [SQL](../glossary.md#abbr-084) (выгрузка и проверка гипотез);
- [BI](../glossary.md#abbr-008) dashboards (Power BI, Tableau, Superset);
- Python/Pandas для статистики и моделирования;
- decision log в Confluence/Jira.

## Практический пример 1: [UX](../glossary.md#abbr-093)-улучшение

[Гипотеза](../glossary.md#term-018): сокращение полей формы повысит conversion на 5%.  
Данные: funnel step1 -> step2 -> submit.  
Решение: A/B тест на 2 недели.  
Критерий успеха: статистически значимый рост conversion без роста ошибок.

## Практический пример 2: приоритизация по impact/cost

| Инициатива | Impact | Cost | Приоритет |
| --- | --- | --- | --- |
| Улучшение onboarding | High | Medium | 1 |
| Новый отчет | Medium | High | 3 |
| Оптимизация поиска | High | Low | 2 |

## Best practices

- фиксировать гипотезу и критерии успеха до изменений;
- проверять качество данных и bias в выборке;
- документировать выводы и решения;
- регулярно проводить data retrospective.

## Кросс-ссылки

- [Оценка трудоемкости](estimation-risks/effort-estimation.md)
- [Финансовая оценка](estimation-risks/financial-evaluation.md)
- [Методологии: Agile](../methodologies/agile.md)
- [Процесс разработки: Agile-практики](../development-process/agile-processes.md)

## Типичные ошибки

- решение по одной метрике без контекста;
- отсутствие контрольной группы в экспериментах;
- игнорирование сезонности и внешних факторов;
- отсутствие decision log.## Источники

- Lean Analytics (Croll/Yoskovitz).
- BABOK v3 (Solution Evaluation).
- [PMBOK](../glossary.md#abbr-064) 7.
- Kohavi et al., *Trustworthy Online Controlled Experiments*.
