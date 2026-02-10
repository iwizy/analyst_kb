# Экономика и финансы

Финансовая грамотность аналитика помогает обосновывать инициативы через деньги, риски и стоимость задержки, а не только через техническую реализуемость.

## Уровни сложности

### Базовый уровень

- понимать revenue, costs, margin, cash flow;
- различать CAPEX и OPEX;
- считать базовый [ROI](../../glossary.md#abbr-073).

### Средний уровень

- считать [NPV](../../glossary.md#abbr-055), [IRR](../../glossary.md#abbr-042), payback period;
- оценивать unit economics ([LTV](../../glossary.md#abbr-048), [CAC](../../glossary.md#abbr-012), burn rate);
- сравнивать альтернативы через [TCO](../../glossary.md#abbr-087).

### Продвинутый уровень

- проводить sensitivity analysis;
- учитывать риск-премию и сценарии;
- использовать cost of delay и [WSJF](../../glossary.md#abbr-095) в приоритизации.

## Что входит в раздел

- [ROI, NPV, IRR](roi-npv-irr.md)
- [TCO](tco.md)

## Ключевые метрики

| [Метрика](../../glossary.md#term-044) | Что показывает | Где используется |
| --- | --- | --- |
| ROI | относительная отдача инвестиций | быстрый отбор инициатив |
| NPV | приведенная ценность потока денег | сравнение проектов на горизонте |
| IRR | внутренняя доходность | оценка инвестиционной привлекательности |
| Payback | срок окупаемости | управление ликвидностью |
| TCO | полная стоимость владения | build vs buy, cloud vs on-prem |
| WSJF | приоритет с учетом cost of delay | roadmap и backlog |

## Пример: SaaS unit economics

- ARPU: 2 500 руб/мес.
- Gross margin: 70%.
- Средний срок жизни клиента: 18 мес.
- CAC: 12 000 руб.

LTV = ARPU * margin * lifetime = 31 500 руб.

LTV/CAC = 2.6. Для роста обычно целевой диапазон >= 3.

## Где аналитик применяет финмодель

- приоритизация backlog и roadmap;
- выбор архитектурного варианта (например, managed service vs self-hosted);
- обоснование автоматизации процессов и интеграций.

## Кросс-ссылки

- [Приоритизация требований](../../requirements/management/prioritization.md)
- [Оценка трудоемкости](../../common-competencies/estimation-risks/effort-estimation.md)
- [Управление продуктом](../product-management.md)## Источники

- Finance for Non-Finance Managers (Coursera).
- The Lean Startup (Eric Ries).
- Corporate Finance Institute: <https://corporatefinanceinstitute.com/>
