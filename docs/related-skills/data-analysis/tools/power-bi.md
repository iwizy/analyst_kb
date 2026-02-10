# Power [BI](../../../glossary.md#abbr-008)

Power BI подходит для корпоративной отчетности и self-service аналитики в Microsoft-экосистеме.

## Уровни сложности

### Базовый уровень

- подключать источники через Power Query;
- строить модель данных и базовые меры;
- публиковать отчеты в Power BI Service.

### Средний уровень

- использовать DAX для [KPI](../../../glossary.md#abbr-047) и временных расчетов;
- настраивать RLS (row-level security);
- оптимизировать refresh и производительность.

### Продвинутый уровень

- строить semantic layer и governance;
- внедрять deployment pipelines;
- стандартизировать дизайн и качество отчетов.

## Мини workflow

1. Подключить данные и очистить в Power Query.
2. Построить модель (желательно star schema).
3. Добавить DAX-меры и справочник KPI.
4. Собрать дашборд с drill-through.
5. Опубликовать, назначить доступ и мониторинг.

## Плюсы и ограничения

| Плюсы | Ограничения |
| --- | --- |
| глубокая интеграция с Microsoft stack | DAX и модель требуют практики |
| хороший enterprise governance | возможна перегрузка модели |
| удобный self-service | риск дублирования KPI без стандартов |

## Кросс-ссылки

- [BI и визуализация](../bi-and-visualization.md)
- [DWH](../dwh.md)
- [Tableau](tableau.md)## Источники

- Power BI docs: <https://learn.microsoft.com/power-bi/>
- DAX Guide: <https://dax.guide/>
