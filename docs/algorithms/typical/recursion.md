# Рекурсия и итерация

Рекурсия описывает задачу через саму себя на меньшем входе. Итерация решает ту же задачу через циклы и явное состояние.

## Уровни сложности

### Базовый

- понимать стек вызовов и base case;
- писать простые рекурсивные функции;
- переводить простую рекурсию в цикл.

### Средний

- использовать хвостовую рекурсию и явный стек;
- сравнивать память и время рекурсивного/итеративного решения;
- избегать stack overflow.

### Продвинутый

- проектировать рекурсивные обходы графов/деревьев;
- применять гибридные подходы (recursion + memoization);
- оценивать влияние глубины рекурсии в production.

## Как работает стек вызовов

```kroki-plantuml
@startuml
participant "main" as M
participant "fact(4)" as F4
participant "fact(3)" as F3
participant "fact(2)" as F2
participant "fact(1)" as F1
M -> F4
F4 -> F3
F3 -> F2
F2 -> F1
F1 --> F2
F2 --> F3
F3 --> F4
F4 --> M
@enduml
```

## Пример: factorial

### Рекурсивно

```text
fact(n):
  if n <= 1: return 1
  return n * fact(n-1)
```

### Итеративно

```text
fact_iter(n):
  result = 1
  for i in 2..n:
    result = result * i
  return result
```

- Время одинаково: `O(n)`.
- Память: рекурсия `O(n)`, итерация `O(1)`.

## Пример: обход дерева

### Рекурсивный DFS

```text
dfs(node):
  if node is null: return
  visit(node)
  dfs(node.left)
  dfs(node.right)
```

### Итеративный DFS

```text
dfs_iter(root):
  stack = [root]
  while stack not empty:
    node = pop(stack)
    visit(node)
    if node.right: push(stack, node.right)
    if node.left: push(stack, node.left)
```

## Tail recursion

```text
fact_tail(n, acc):
  if n <= 1: return acc
  return fact_tail(n-1, n*acc)
```

Если язык поддерживает TCO (tail call optimization), можно снизить расход стека.

## Плюсы и минусы

| Подход | Плюсы | Минусы |
| --- | --- | --- |
| Рекурсия | читаемый код для иерархий | риск переполнения стека |
| Итерация | меньше память, обычно быстрее | больше ручного состояния |

## Типичные ошибки

- отсутствие корректного base case;
- бесконечная рекурсия;
- изменение общего состояния без контроля;
- перевод в цикл с потерей логики обхода.
## Задачи для самопроверки

1. Перепишите рекурсивный inorder обход в итеративный.
2. Реализуйте вычисление степени числа рекурсивно и итеративно.
3. Для дерева глубины 20 оцените объем стека вызовов.

## Источники и дальнейшее изучение

- SICP, главы о рекурсии и процессах.
- CLRS, recursion patterns.
- Python recursion limits docs.
