# Управление продуктом

Product management помогает аналитику связывать требования с ценностью, а не только с реализацией.

## Уровни сложности

### Базовый уровень

- понимать `vision -> strategy -> roadmap -> backlog`;
- формулировать проблему и гипотезу;
- определять метрику успеха инициативы.

### Средний уровень

- участвовать в discovery и приоритизации;
- связывать user stories с North Star и funnel-метриками;
- готовить mini business case по инициативе.

### Продвинутый уровень

- вести discovery-to-delivery цикл;
- управлять зависимостями между командами и доменами;
- использовать портфельный подход к инициативам.

## Каркас продуктового управления

| Элемент | Что фиксируем | Типичный артефакт |
| --- | --- | --- |
| Vision | зачем существует продукт | vision statement |
| Strategy | как достигаем vision | strategy map |
| Roadmap | что делаем по кварталам | roadmap |
| Backlog | чем занимаемся в ближайших итерациях | epic/story backlog |
| Metrics | как измеряем результат | [KPI](../glossary.md#abbr-047)/[OKR](../glossary.md#abbr-058) dashboard |

## Метрики и использование

| [Метрика](../glossary.md#term-044) | Для чего | Инструмент |
| --- | --- | --- |
| North Star | долгосрочная ценность | [BI](../glossary.md#abbr-008) dashboard |
| Conversion | эффективность воронки | product analytics |
| Retention | удержание | cohorts |
| [NPS](../glossary.md#abbr-054) | удовлетворенность | survey tools |

## Цикл Discovery -> Define -> Deliver -> Learn

1. Discovery: интервью, problem framing, [UX](../glossary.md#abbr-093) research.
2. Define: [JTBD](../glossary.md#abbr-045)/personas, scope, критерии успеха.
3. Deliver: MVP, delivery plan, управление зависимостями.
4. Learn: анализ данных, обратная связь, корректировка roadmap.

## Шаблон мини-инициативы

| Поле | Описание |
| --- | --- |
| Цель | какой бизнес-результат нужен |
| Problem Statement | какую проблему решаем |
| Hypothesis | почему решение должно сработать |
| Expected Outcome | ожидаемый эффект |
| Success Metrics | как измерим успех |
| Timeline | сроки проверки |
| Risks & Assumptions | ключевые допущения и риски |
| Dependencies | внешние зависимости |

Пример:

- Цель: увеличить repeat purchase rate на 8%.
- [Гипотеза](../glossary.md#term-018): персональные рекомендации в корзине повышают повторные покупки.
- Success metric: repeat purchase rate 30-day.
- Срок: 6 недель, 2 спринта разработки + 2 недели наблюдения.

## Типичные ошибки

- backlog без связи с продуктовыми целями;
- фокус на output (количество фич), а не outcome;
- релиз без плана измерения эффекта;
- отсутствие rollback-гипотезы при негативном результате.

## Кросс-ссылки

- [Приоритизация требований](../requirements/management/prioritization.md)
- [Data-driven решения](../common-competencies/data-driven-decisions.md)
- [Agile-процессы](../development-process/agile-processes.md)

## Источники

- Inspired (Marty Cagan).
- Escaping the Build Trap (Melissa Perri).
- Continuous Discovery Habits (Teresa Torres).
- Product School: <https://productschool.com/resources>
- Mind the Product: <https://www.mindtheproduct.com/>
