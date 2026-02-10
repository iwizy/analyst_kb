# MVC, MVP, MVVM

Это паттерны организации UI-логики, которые определяют разделение ответственности между представлением, состоянием и пользовательскими действиями.

## Уровни сложности

### Базовый уровень

- понимать роли View/Model/Controller(Presenter/ViewModel);
- выбирать паттерн под UI-фреймворк;
- избегать смешения бизнес-логики и отображения.

### Средний уровень

- проектировать testable presentation layer;
- управлять состоянием и side-effects;
- использовать binding/reactive механизмы осознанно.

### Продвинутый уровень

- строить масштабируемую frontend-архитектуру по доменам;
- сочетать UI-паттерны с микрофронтендами;
- минимизировать coupling между UI и backend.

## Сравнение

| Паттерн | Идея | Плюсы | Минусы |
| --- | --- | --- | --- |
| MVC | Controller управляет View/Model | простая модель | controller часто разрастается |
| MVP | Presenter содержит presentation logic | высокая testability | больше boilerplate |
| MVVM | ViewModel + data binding | удобно для reactive UI | сложнее отладка binding |

## Когда что выбирать

- MVC: классические web-приложения с server-side rendering.
- MVP: когда важна unit-testability UI-логики.
- MVVM: современные reactive frameworks и rich-client приложения.

## Типичные ошибки

- бизнес-логика в View/компонентах;
- размытые границы между Presenter/ViewModel и сервисами;
- чрезмерный binding без контроля производительности.

## Практические рекомендации

1. Держите domain logic вне UI паттерна.
2. Используйте DTO/view model, а не доменные объекты напрямую.
3. Фиксируйте state transitions и side-effects.
4. Сверяйте решение с [микрофронтендами](microfrontends.md).

## Контрольные вопросы

1. Какой паттерн лучше подходит вашему текущему frontend стеку?
2. Где сейчас находится бизнес-логика UI и правильно ли это?
3. Насколько легко тестировать presentation слой?
4. Какие компоненты чаще всего нарушают паттерн?

## Чек-лист самопроверки

- выбран и формализован UI-паттерн;
- presentation logic отделена от domain logic;
- state management стратегия понятна;
- есть UI unit/integration тесты;
- архитектура поддерживает масштабирование UI-команд.

## Стандарты и источники

- Fowler, UI architectural patterns articles.
- Framework-specific architecture guides (Angular/React/.NET).
