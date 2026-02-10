# Алгоритмы сортировки

Сортировка — базовый инструмент подготовки данных для поиска, агрегаций и аналитики. Выбор алгоритма зависит от объема данных, распределения ключей, требований к стабильности и памяти.

## Уровни сложности

### Базовый

- отличать устойчивые и неустойчивые сортировки;
- знать `O(n^2)` и `O(n log n)` алгоритмы;
- выбирать сортировку для малого массива.

### Средний

- учитывать in-place vs extra-memory;
- понимать внешнюю сортировку для больших файлов;
- применять counting/radix для целочисленных ключей.

### Продвинутый

- выбирать гибридные подходы (introsort, timsort);
- оптимизировать pivot и partition в quicksort;
- проектировать сортировку в распределенных системах.

## Классификация

| Критерий | Варианты |
| --- | --- |
| Стабильность | устойчивые / неустойчивые |
| Память | in-place / с дополнительной памятью |
| Модель | сравнивающие / не сравнивающие |
| Среда | внутренняя / внешняя сортировка |

## Сравнительная таблица

| Алгоритм | Лучший | Средний | Худший | Память | Стабильность |
| --- | --- | --- | --- | --- | --- |
| Bubble | O(n) | O(n^2) | O(n^2) | O(1) | да |
| Insertion | O(n) | O(n^2) | O(n^2) | O(1) | да |
| Selection | O(n^2) | O(n^2) | O(n^2) | O(1) | нет |
| Quick | O(n log n) | O(n log n) | O(n^2) | O(log n) | нет |
| Merge | O(n log n) | O(n log n) | O(n log n) | O(n) | да |
| Heap | O(n log n) | O(n log n) | O(n log n) | O(1) | нет |
| Counting | O(n + k) | O(n + k) | O(n + k) | O(n + k) | да |
| Radix | O(d*(n + k)) | O(d*(n + k)) | O(d*(n + k)) | O(n + k) | зависит |

## Простые O(n^2) алгоритмы

### Bubble sort

```text
bubble_sort(a):
  n = len(a)
  for i in 0..n-1:
    swapped = false
    for j in 0..n-2-i:
      if a[j] > a[j+1]:
        swap(a[j], a[j+1])
        swapped = true
    if not swapped: break
```

- Хорош для: учебных задач и почти отсортированных массивов малого размера.
- Плюс: простота.
- Минус: плохая масштабируемость.

### Insertion sort

```text
insertion_sort(a):
  for i in 1..len(a)-1:
    key = a[i]
    j = i - 1
    while j >= 0 and a[j] > key:
      a[j+1] = a[j]
      j = j - 1
    a[j+1] = key
```

- Хорош для: малых массивов, online-вставок.

### Selection sort

```text
selection_sort(a):
  n = len(a)
  for i in 0..n-1:
    min_idx = i
    for j in i+1..n-1:
      if a[j] < a[min_idx]: min_idx = j
    swap(a[i], a[min_idx])
```

- Хорош для: когда количество swap критично.

## Quicksort

```text
quicksort(a, l, r):
  if l >= r: return
  p = partition(a, l, r)    // pivot placement
  quicksort(a, l, p-1)
  quicksort(a, p+1, r)
```

- Среднее: `O(n log n)`, худшее: `O(n^2)`.
- Оптимизации: random pivot, median-of-three, tail recursion elimination.
- Практика: часто fastest in-memory for primitive arrays.

## Merge sort

```text
merge_sort(a):
  if len(a) <= 1: return a
  mid = len(a)/2
  left = merge_sort(a[0:mid])
  right = merge_sort(a[mid:])
  return merge(left, right)
```

- Всегда `O(n log n)`, стабильный, но требует `O(n)` памяти.
- Полезен для внешней сортировки больших файлов.

## Heap sort

```text
heap_sort(a):
  build_max_heap(a)
  for i from len(a)-1 downto 1:
    swap(a[0], a[i])
    heapify(a, 0, i)
```

- `O(n log n)` worst-case, `O(1)` extra memory.
- Trade-off: медленнее quicksort на практике, но предсказуемее worst-case.

## Counting и Radix sort

### Counting sort

```text
counting_sort(a, k):
  count[0..k] = 0
  for x in a: count[x]++
  prefix sums over count
  place elements into output using count
```

- `O(n + k)`, работает при ограниченном диапазоне ключей.

### Radix sort (LSD)

```text
radix_sort(a, digits):
  for d in 0..digits-1:
    stable_sort_by_digit(a, d)
```

- Для целых/строк фиксированной длины, линейно по числу разрядов.

## Пример на одном массиве

Массив: `[7, 3, 9, 3, 1]`

- Insertion: шаг за шагом сдвигает элементы влево.
- Merge: делит на `[7,3]` и `[9,3,1]`, затем сливает.
- Quick: выбирает pivot (например, 3), делит на `<3`, `=3`, `>3`.

## Мини-реализации на языках

### Python (quicksort, упрощенно)

```python
def qsort(a):
    if len(a) <= 1:
        return a
    p = a[len(a)//2]
    left = [x for x in a if x < p]
    mid = [x for x in a if x == p]
    right = [x for x in a if x > p]
    return qsort(left) + mid + qsort(right)
```

### Java (merge sort, фрагмент)

```java
void mergeSort(int[] a, int l, int r) {
    if (l >= r) return;
    int m = (l + r) / 2;
    mergeSort(a, l, m);
    mergeSort(a, m + 1, r);
    merge(a, l, m, r);
}
```

### C++ (heap sort, фрагмент)

```cpp
std::make_heap(v.begin(), v.end());
std::sort_heap(v.begin(), v.end());
```

## Типичные ошибки

- выбор unstable sort там, где важен порядок равных ключей;
- quicksort без защиты от worst-case pivot;
- counting sort для огромного диапазона `k`;
- игнорирование memory footprint merge sort.

## Контрольные вопросы

1. Почему merge sort часто выбирают для внешней сортировки?
2. В каких условиях quicksort деградирует до O(n^2)?
3. Когда counting sort выгоднее сравнивающих алгоритмов?
4. Что важнее в вашем кейсе: стабильность или экономия памяти?

## Задачи для самопроверки

1. Отсортируйте массив из 100 элементов insertion и quicksort, сравните время.
2. Для почти отсортированного массива сравните bubble (с флагом) и merge.
3. Подберите алгоритм для сортировки возраста пользователей (0..120).
4. Реализуйте quicksort с random pivot.

## Источники и дальнейшее изучение

- CLRS, главы 2, 7, 8.
- Sedgewick, сортировки.
- Knuth, Vol. 3 (sorting and searching).
