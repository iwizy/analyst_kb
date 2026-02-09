# Алгоритмы сортировки

Сортировка нужна для отчетности, ранжирования, дедупликации, подготовки витрин и ускорения последующего поиска.

## Сравнение Quick Sort, Merge Sort, Heap Sort

| Алгоритм | Средняя сложность | Худший случай | Память | Стабильность | Когда выбирать |
| --- | --- | --- | --- | --- | --- |
| Quick sort | `O(n log n)` | `O(n^2)` | `O(log n)` (рекурсия) | Нет | Быстрая in-memory сортировка, если worst-case приемлем |
| Merge sort | `O(n log n)` | `O(n log n)` | `O(n)` | Да | Важна стабильность и предсказуемость времени |
| Heap sort | `O(n log n)` | `O(n log n)` | `O(1)` доп. память | Нет | Нужен гарантированный worst-case и ограниченная память |

## Псевдокод

### Quick Sort

```text
quickSort(A, low, high):
  if low >= high:
    return
  p = partition(A, low, high)
  quickSort(A, low, p - 1)
  quickSort(A, p + 1, high)

partition(A, low, high):
  pivot = A[high]
  i = low - 1
  for j from low to high - 1:
    if A[j] <= pivot:
      i = i + 1
      swap A[i], A[j]
  swap A[i + 1], A[high]
  return i + 1
```

### Merge Sort

```text
mergeSort(A):
  if length(A) <= 1:
    return A
  mid = length(A) / 2
  left = mergeSort(A[0..mid-1])
  right = mergeSort(A[mid..end])
  return merge(left, right)

merge(left, right):
  result = []
  i = 0, j = 0
  while i < len(left) and j < len(right):
    if left[i] <= right[j]:
      append left[i] to result; i++
    else:
      append right[j] to result; j++
  append remaining left and right to result
  return result
```

### Heap Sort

```text
heapSort(A):
  buildMaxHeap(A)
  for i from n - 1 down to 1:
    swap A[0], A[i]
    heapSize = heapSize - 1
    heapify(A, 0, heapSize)

heapify(A, i, heapSize):
  largest = i
  left = 2*i + 1
  right = 2*i + 2
  if left < heapSize and A[left] > A[largest]:
    largest = left
  if right < heapSize and A[right] > A[largest]:
    largest = right
  if largest != i:
    swap A[i], A[largest]
    heapify(A, largest, heapSize)
```

## Бизнес-сценарии

- E-commerce: сортировка каталога по релевантности и цене.
- Банкинг: стабильная сортировка операций по дате и приоритету.
- Логистика: сортировка отгрузок по SLA и времени дедлайна.

## Типичные ошибки

- выбирать `O(n^2)` на больших выборках без профилирования;
- игнорировать стабильность сортировки при одинаковых ключах;
- сортировать повторно внутри цикла вместо одного прохода.

## Самопроверка

1. Почему merge sort лучше quick sort, если важна стабильность?
1. В каком сценарии heap sort предпочтительнее quick sort?
1. Что произойдет с quick sort при неудачном выборе pivot?
