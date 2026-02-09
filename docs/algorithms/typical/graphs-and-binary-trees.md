# Графы, деревья и хеш-таблицы

Эти структуры данных покрывают типовые прикладные задачи: маршруты, зависимости, иерархии и быстрый доступ по ключу.

## Графы: BFS, DFS, кратчайшие пути

### Что решают

- `BFS`: поиск в ширину, минимальное число ребер до цели в невзвешенном графе.
- `DFS`: поиск в глубину, обход зависимостей, поиск циклов.
- `Dijkstra`: кратчайший путь в графе с неотрицательными весами.

### Псевдокод BFS

```text
BFS(graph, start):
  queue = [start]
  visited = {start}
  while queue not empty:
    v = dequeue(queue)
    process(v)
    for each u in neighbors(v):
      if u not in visited:
        visited.add(u)
        enqueue(queue, u)
```

### Псевдокод DFS

```text
DFS(graph, v, visited):
  visited.add(v)
  process(v)
  for each u in neighbors(v):
    if u not in visited:
      DFS(graph, u, visited)
```

### Псевдокод Dijkstra

```text
Dijkstra(graph, source):
  dist[source] = 0
  all other dist = INF
  pq = min-priority-queue(source)
  while pq not empty:
    v = extract-min(pq)
    for each edge (v, u, w):
      if dist[v] + w < dist[u]:
        dist[u] = dist[v] + w
        decrease-key(pq, u, dist[u])
  return dist
```

### Бизнес-пример

Логистика: узлы - склады/пункты доставки, ребра - дороги с весом `время`. Dijkstra находит минимальное время маршрута до клиента.

## Деревья: AVL и B-tree

| Структура | Где применяют | Плюсы | Ограничения |
| --- | --- | --- | --- |
| AVL-дерево | in-memory индексы, частые чтения | строго сбалансировано, `O(log n)` | больше вращений при вставке/удалении |
| B-tree | индексы БД и файловых систем | оптимально для диска/страниц, мало обращений к storage | сложнее реализация |

### Псевдокод идеи вставки в AVL

```text
insertAVL(node, key):
  insert as in BST
  update height(node)
  balance = height(left) - height(right)
  if balance out of range:
    perform rotations (LL, RR, LR, RL)
  return new root
```

## Хеш-таблицы

Хеш-таблица хранит пары `key -> value` и дает в среднем `O(1)` для `put/get/delete`.

### Что важно в проектировании

- выбор хеш-функции;
- стратегия коллизий (цепочки, открытая адресация);
- контроль `load factor` и рехеширование.

### Бизнес-пример

Антифрод: быстрый lookup "карта/устройство/клиент" для проверки лимитов в real-time.

## Типичные ошибки

- выбирать DFS вместо BFS, когда нужен путь с минимальным числом шагов;
- игнорировать веса ребер и использовать BFS для weighted graph;
- строить хеш-таблицу без контроля коллизий.

## Самопроверка

1. Почему BFS подходит для поиска "минимум пересадок"?
1. Когда Dijkstra неприменим и нужен Bellman-Ford?
1. Почему B-tree эффективнее AVL для индексов СУБД на диске?
