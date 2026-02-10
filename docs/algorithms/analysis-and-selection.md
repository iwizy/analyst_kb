# Анализ и выбор алгоритмов

Выбор алгоритма — это инженерное решение между требованиями, ограничениями платформы и свойствами данных.

## Уровни сложности

### Базовый

- формализовать требования к алгоритму;
- сравнить кандидаты по времени и памяти;
- выбрать baseline решение.

### Средний

- анализировать best/avg/worst-case;
- проводить benchmark на реальных данных;
- учитывать стабильность, детерминированность и точность.

### Продвинутый

- использовать approximation/heuristics при NP-трудности;
- проектировать гибридные стратегии;
- автоматизировать performance regression контроль.

## Методология выбора

1. Определите целевые требования: latency, throughput, memory, correctness.
2. Опишите входные данные: размер, распределение, упорядоченность, диапазон.
3. Сформируйте shortlist алгоритмов и структур.
4. Сравните best/avg/worst-case и риск деградации.
5. Проведите нагрузочный тест на representative dataset.
6. Выберите решение и зафиксируйте ADR.

## Trade-off время/память

| Сценарий | Предпочтение |
| --- | --- |
| latency критична, память доступна | использовать кэш/индексы и precompute |
| память ограничена | in-place алгоритмы, stream processing |
| точность критична | точные алгоритмы вместо эвристик |
| время разработки ограничено | библиотечные реализации и проверенные паттерны |

## Когда нужны heuristic/approximation

- задача NP-hard и точное решение дорого;
- нужен near-optimal ответ в fixed time budget;
- бизнес допускает контролируемую ошибку.

Примеры:

- route planning с эвристиками;
- bin packing (First Fit Decreasing);
- кластеризация в аналитике.

## Сравнение библиотек

| Экосистема | Инструменты |
| --- | --- |
| C++ | STL (`sort`, `lower_bound`, `priority_queue`), Boost Graph |
| Java | `Collections`, `Arrays`, Guava |
| Python | `bisect`, `heapq`, `collections`, `networkx` |
| Apache | Commons Math, Commons Collections |

## Мини-процедура benchmark

```text
for each candidate algorithm:
  run warm-up
  measure p50/p95 latency on representative input
  measure memory peak
  test worst-case synthetic input
choose algorithm by weighted criteria
```

## Плюсы и минусы формального подхода

| Плюсы | Минусы |
| --- | --- |
| прозрачные и воспроизводимые решения | требует времени и дисциплины |
| меньше "случайных" выборов алгоритмов | нужен качественный тестовый набор |
| проще защищать решение перед стейкхолдерами | не исключает доменные неизвестные |

## Типичные ошибки

- выбор по привычке вместо данных;
- сравнение на маленьком и нерепрезентативном `n`;
- отсутствие worst-case тестов;
- игнорирование стоимости сопровождения.
## Задачи для самопроверки

1. Составьте matrix выбора для задачи ранжирования 1 млн записей.
2. Сравните два алгоритма по p95 latency и memory peak.
3. Зафиксируйте алгоритмический выбор в формате ADR.

## Источники и дальнейшее изучение

- Skiena, chapters on practical algorithm design.
- Google SRE workbook (performance budgets).
- C++ STL docs: <https://en.cppreference.com/>
- Guava docs: <https://github.com/google/guava>
