# XP

XP (Extreme Programming) - инженерная методика для быстрой и безопасной поставки через сильные практики качества.

## Принципы

- communication;
- simplicity;
- feedback;
- courage;
- respect.

## Этапы цикла XP (короткий)

1. Формулировка user story и acceptance tests.
1. TDD-цикл (Red-Green-Refactor).
1. Pair programming/collective review.
1. Continuous integration.
1. Малый релиз.

## Артефакты

- user stories;
- acceptance tests;
- unit tests;
- coding standards;
- CI results.

## Роли

- заказчик (on-site customer);
- разработчики;
- tester/QA;
- coach.

## Плюсы и минусы

Плюсы:

- низкий дефектный поток;
- высокая адаптивность к изменениям.

Минусы:

- требует высокой инженерной дисциплины;
- сложно внедрять фрагментарно.

## Пример подходящего проекта

Сервис с частыми изменениями бизнес-правил, где стоимость регрессии высока.

## Связь с требованиями и рисками

- требования формулируются как testable examples;
- техриски снижаются через раннюю автоматизацию;
- риски качества видны через CI и test failure trends.
