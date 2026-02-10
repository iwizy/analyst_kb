# Комбинаторика и backtracking (продвинутый уровень)

Комбинаторные алгоритмы генерируют варианты решений и часто применяются в задачах расписаний, раскладки и constraint satisfaction.

## Уровни сложности

### Базовый

- генерировать комбинации/перестановки;
- понимать дерево перебора;
- использовать pruning.

### Средний

- применять backtracking для N-Queens/Sudoku;
- использовать bitmask и branch-and-bound;
- оценивать экспоненциальную сложность.

### Продвинутый

- применять exact cover и Dancing Links;
- проектировать эвристики порядка выбора ветвей.

## Базовый шаблон backtracking

```text
search(state):
  if goal(state): record solution; return
  for choice in choices(state):
    if feasible(choice, state):
      apply(choice, state)
      search(state)
      undo(choice, state)
```

## Примеры

- N-Queens
- Sudoku solver
- генерация подмножеств/перестановок

## Dancing Links (DLX)

- Эффективная структура для exact cover задач.
- Сильно ускоряет поиск в плотных ограничениях.

## Контрольные вопросы

1. Что дает pruning в backtracking?
2. Почему порядок выбора ветвей важен?
3. Для каких задач DLX оправдан?

## Задачи для самопроверки

1. Реализуйте генерацию всех подмножеств множества.
2. Напишите solver N-Queens.
3. Добавьте эвристику MRV для Sudoku.

## Источники

- Knuth, *Dancing Links* paper.
- Skiena, combinatorial search.
