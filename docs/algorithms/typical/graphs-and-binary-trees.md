# Графы и деревья

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Графовые и древовидные алгоритмы критичны для маршрутизации, зависимостей, планирования и анализа сетей.

## Уровни сложности

### Базовый

- понимать граф как `V` вершин и `E` ребер;
- применять BFS/DFS;
- различать представления графа.

### Средний

- решать shortest path задачи (Dijkstra, Bellman-Ford);
- строить MST (Prim, Kruskal);
- выполнять topological sort для DAG.

### Продвинутый

- применять A* и max-flow;
- выбирать алгоритм под тип весов и ограничения;
- связывать графовые модели с бизнес-процессами.

## Представления графа

| Представление | Память | Поиск ребра | Где удобно |
| --- | --- | --- | --- |
| Матрица смежности | O(V^2) | O(1) | плотные графы |
| Список смежности | O(V + E) | O(deg(v)) | разреженные графы |

## BFS и DFS

### BFS (поиск в ширину)

```text
bfs(graph, s):
  mark s visited
  queue = [s]
  while queue not empty:
    v = pop_front(queue)
    for u in adj[v]:
      if not visited[u]:
        visited[u] = true
        parent[u] = v
        push_back(queue, u)
```

### DFS (поиск в глубину)

```text
dfs(v):
  visited[v] = true
  for u in adj[v]:
    if not visited[u]:
      dfs(u)
```

- Сложность обоих: `O(V + E)`.

## Кратчайшие пути

### Dijkstra

- Условия: веса ребер неотрицательные.
- Сложность: `O((V + E) log V)` с priority queue.

```text
dijkstra(s):
  dist[*] = INF; dist[s] = 0
  pq.push((0,s))
  while pq not empty:
    (d,v) = pq.pop_min()
    if d != dist[v]: continue
    for (u,w) in adj[v]:
      if dist[v] + w < dist[u]:
        dist[u] = dist[v] + w
        pq.push((dist[u], u))
```

### Bellman-Ford

- Поддерживает отрицательные веса.
- Сложность: `O(VE)`.
- Дополнительно: обнаруживает отрицательные циклы.

### A*

- `f(n) = g(n) + h(n)` где `h` — эвристика.
- Эффективен, если эвристика допустима и информативна.

## MST: Prim и Kruskal

| Алгоритм | Идея | Сложность |
| --- | --- | --- |
| Prim | наращивает дерево от вершины | O(E log V) |
| Kruskal | сортирует ребра + DSU | O(E log E) |

```text
kruskal(edges):
  sort edges by weight
  make_set(v) for all v
  mst = []
  for (u,v,w) in edges:
    if find(u) != find(v):
      union(u,v)
      mst.add((u,v,w))
```

## DAG: топологическая сортировка и критический путь

- Topological sort: линейный порядок вершин DAG.
- Применение: dependency management, build pipelines.
- PERT/CPM: расчет critical path для оценки сроков проекта.

## Максимальный поток

| Алгоритм | Идея | Сложность |
| --- | --- | --- |
| Edmonds-Karp | BFS в residual graph | O(VE^2) |
| Dinic | level graph + blocking flow | O(V^2E) (общий случай) |

## Деревья для поиска

- AVL/RB-tree: сбалансированные `O(log n)` операции.
- B-tree: оптимален для дисковых индексов.
- Связь с БД: индексы и планы запросов в [разделе БД](../../database/sql/indexes.md).

## Диаграмма: выбор графового алгоритма

```kroki-plantuml
@startuml
start
if (Нужен shortest path?) then (yes)
  if (Есть отрицательные веса?) then (yes)
    :Bellman-Ford;
  else (no)
    if (Есть хорошая эвристика?) then (yes)
      :A*;
    else (no)
      :Dijkstra;
    endif
  endif
else (no)
  if (Нужен остов?) then (yes)
    :Prim or Kruskal;
  else (no)
    :BFS/DFS/Topo/Flow;
  endif
endif
stop
@enduml
```

## Типичные ошибки

- применение Dijkstra при отрицательных весах;
- неверный выбор представления графа;
- забытая проверка на циклы в DAG;
- отсутствие проверки корректности эвристики в A*.
## Задачи для самопроверки

1. Реализуйте BFS и DFS для одного графа и сравните порядок обхода.
2. Для графа дорог выберите Dijkstra или A* и обоснуйте.
3. Найдите MST для заданного набора ребер двумя методами.
4. Постройте топологический порядок задач релизного пайплайна.

## Источники и дальнейшее изучение

- CLRS, главы 22-26.
- Tarjan, графовые алгоритмы.
- A* original paper (Hart, Nilsson, Raphael).
