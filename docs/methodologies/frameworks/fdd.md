# FDD (Feature-Driven Development)

FDD организует поставку вокруг бизнес-фич, обеспечивая прозрачный прогресс в терминах ценности.

## Уровни сложности

### Базовый уровень

- понимать идею feature-centric delivery;
- знать 5 шагов FDD;
- использовать feature list как основной плановый артефакт.

### Средний уровень

- декомпозировать требования в feature sets;
- управлять ролями Chief Programmer/Class Owner;
- отслеживать статус по фичам и зависимостям.

### Продвинутый уровень

- применять FDD для крупных B2B-программ;
- сочетать FDD с DDD и архитектурными ограничениями;
- контролировать качество на уровне feature lifecycle.

## Процесс FDD

1. Develop an overall model.
2. Build a features list.
3. Plan by feature.
4. Design by feature.
5. Build by feature.

## Артефакты и роли

| Артефакт | Назначение |
| --- | --- |
| Features List | каталог бизнес-функций |
| Feature Plan | дорожная карта по фичам |
| Design Package | проектные решения по фиче |
| Build Status Board | статус выполнения фич |

| Роль | Зона ответственности |
| --- | --- |
| Chief Architect | архитектурный каркас |
| Chief Programmer | delivery по группе фич |
| Class Owner | ответственность за код класса |
| Domain Expert | проверка бизнес-смысла |

## Шаблон Feature List (фрагмент)

| Feature ID | Feature Set | Business Value | Owner | Status |
| --- | --- | --- | --- | --- |
| F-PAY-015 | Payments | High | Chief Programmer A | Design |

## Плюсы и ограничения

Плюсы:

- прозрачный прогресс в языке бизнеса;
- хорошо масштабируется на feature-команды;
- удобен для программ с четким функциональным scope.

Ограничения:

- выше зависимость от архитектурного лидерства;
- слабее работает в exploratory/discovery задачах.

## Пример проекта

B2B-платформа с несколькими клиентскими сегментами, где релиз планируется пакетами функциональности.

## Связь с требованиями и рисками

- требования агрегируются по feature sets;
- change control ведется на уровне feature;
- риски отслеживаются в feature plan и design package.

## Типичные ошибки

- путаница между фичей и технической задачей;
- отсутствие единой доменной модели;
- статус по задачам вместо статуса по фичам.## Источники

- Coad, De Luca, Lefebvre, *Java Modeling in Color with UML* (истоки FDD).
- Agile Alliance FDD overview: <https://www.agilealliance.org/glossary/fdd/>
