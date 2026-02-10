# Структуры данных
> Глоссарий терминов и сокращений: [Открыть](../glossary.md)



Выбор структуры данных определяет эффективность алгоритма не меньше, чем выбор самой процедуры обработки.

## Уровни сложности

### Базовый

- знать назначение ключевых структур;
- понимать базовые операции и их сложность;
- выбирать структуру под простые сценарии поиска/добавления.

### Средний

- учитывать trade-off между скоростью и памятью;
- выбирать структуру под read-heavy/write-heavy профиль;
- связывать структуру данных с алгоритмом и доменной моделью.

### Продвинутый

- использовать продвинутые деревья и приоритетные структуры;
- проектировать структуры под high-load и конкурентный доступ;
- учитывать распределенные и внешние хранилища.

## Сводная таблица операций

| Структура | Доступ | Поиск | Вставка | Удаление | Типичный сценарий |
| --- | --- | --- | --- | --- | --- |
| Массив | O(1) | O(n) | O(n) | O(n) | индексный доступ, batch processing |
| Связный список | O(n) | O(n) | O(1) в начало | O(n) | частые вставки/удаления |
| Стек | O(1) top | O(n) | O(1) push | O(1) pop | backtracking, call stack |
| Очередь | O(1) front | O(n) | O(1) enqueue | O(1) dequeue | FIFO обработка задач |
| Приоритетная очередь (heap) | O(1) max/min | O(n) | O(log n) | O(log n) | планировщик, топ-k |
| Хеш-таблица | - | O(1)* | O(1)* | O(1)* | индексы, словари, кэш |
| BST (сбаланс.) | O(log n) | O(log n) | O(log n) | O(log n) | упорядоченный словарь |
| AVL/RB-tree | O(log n) | O(log n) | O(log n) | O(log n) | частые поиски и обновления |
| B-tree | O(log n) | O(log n) | O(log n) | O(log n) | дисковые БД, файловые системы |
| Граф (adj list) | - | O(V+E) обход | O(1) ребро | O(1)/O(deg) | маршруты, зависимости |

`*` амортизированно, зависит от коллизий и resize.

## Схема: стек, очередь, хеш и дерево

```kroki-plantuml
@startuml
left to right direction
rectangle "Stack\nLIFO" as S
rectangle "Queue\nFIFO" as Q
rectangle "HashMap\nkey -> bucket" as H
rectangle "Balanced Tree\nordered keys" as T
S --> Q : обработка задач
H --> T : выбор между O(1) и ordered O(log n)
@enduml
```

## Псевдокод базовых операций

### Стек

```text
push(stack, x):
  stack.top = stack.top + 1
  stack[stack.top] = x

pop(stack):
  if stack.top < 0: error
  x = stack[stack.top]
  stack.top = stack.top - 1
  return x
```

### Очередь

```text
enqueue(q, x):
  q.tail = (q.tail + 1) mod q.capacity
  q[q.tail] = x

dequeue(q):
  if q.empty: error
  x = q[q.head]
  q.head = (q.head + 1) mod q.capacity
  return x
```

### Хеш-таблица (цепочки)

```text
put(map, key, value):
  i = hash(key) mod m
  if key exists in bucket[i]: update
  else append (key, value) to bucket[i]
```

### AVL-вставка (идея)

```text
insert(node, key):
  if node is null: return new Node(key)
  if key < node.key: node.left = insert(node.left, key)
  else if key > node.key: node.right = insert(node.right, key)
  update_height(node)
  return rebalance(node)
```

## Где что выбирать

| Сценарий | Рекомендуемая структура | Почему |
| --- | --- | --- |
| Частые lookup по ключу | HashMap | среднее O(1) |
| Нужен отсортированный обход | RB-tree/AVL | order + O(log n) |
| Очередь событий | Queue / Priority Queue | FIFO или приоритет |
| Каталог/индекс в БД | B-tree | оптимально для диска |
| Социальный граф | Adjacency list | эффективен при разреженных ребрах |

## Типичные ошибки

- использование списка там, где нужен индекс/хеш;
- игнорирование роста коллизий в hash-таблице;
- выбор несбалансированного дерева для больших `n`;
- забытый cost памяти при дублировании структур.
## Задачи для самопроверки

1. Спроектируйте структуру для кэша с быстрым lookup и eviction policy.
2. Подберите структуру для очереди заявок с SLA-приоритетом.
3. Сравните хранение маршрутов в матрице и списке смежности.

## Источники и дальнейшее изучение

- CLRS, главы по структурам данных.
- Sedgewick, раздел Data Structures.
- Tarjan, *Data Structures and Network Algorithms*.
- PostgreSQL docs (B-tree indexes): <https://www.postgresql.org/docs/current/btree.html>
