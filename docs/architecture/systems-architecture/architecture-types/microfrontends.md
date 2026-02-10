# Микрофронтенды

Микрофронтенды делят [UI](../../../glossary.md#abbr-091) на доменные части с независимым lifecycle и ownership команд.

## Уровни сложности

### Базовый уровень

- понимать идею независимых UI-модулей;
- выбирать способ композиции интерфейса;
- поддерживать единый [UX](../../../glossary.md#abbr-093) baseline.

### Средний уровень

- управлять shared dependencies и дизайн-системой;
- строить межмодульные контракты;
- внедрять сквозную observability фронтенда.

### Продвинутый уровень

- оптимизировать performance и bundle strategy;
- внедрять runtime composition и version governance;
- управлять distributed frontend at scale.

## Подходы к реализации

| Подход | Сильные стороны | Ограничения |
| --- | --- | --- |
| iFrame | сильная изоляция | UX/performance ограничения |
| Web Components | стандартизованный browser-level composition | сложность shared state |
| Module Federation | гибкая runtime-композиция | управление версиями и зависимостями |

## Преимущества

- независимый релиз UI-команд;
- быстрые изменения в доменах;
- лучшее соответствие org-структуре продукта.

## Недостатки

- риск фрагментации UX;
- дублирование библиотек;
- сложность сквозной аналитики и ошибок.

## Антипаттерны

- отсутствие общей design system;
- глобальный state без ownership;
- разные стандарты accessibility/performance.

## Практические рекомендации

1. Введите единые UI-токены и гайдлайн.
2. Зафиксируйте [API](../../../glossary.md#abbr-005) коммуникации между модулями.
3. Контролируйте web-vitals per module.
4. Связывайте решение с [интеграциями API](../../../integrations/api-design/index.md).
## Стандарты и источники

- Martin Fowler microfrontends articles.
- Module Federation docs.
- Web Components standards.
