# Инструменты моделирования

Раздел помогает выбрать инструменты моделирования под разные типы артефактов: UML, BPMN, C4, ArchiMate, ERD и процессные схемы.

## Уровни сложности

### Базовый уровень

- выбрать инструмент под конкретную нотацию;
- построить базовую диаграмму и согласовать с командой;
- сохранить артефакт в репозитории/knowledge base.

### Средний уровень

- организовать совместную работу и review моделей;
- внедрить единые шаблоны и naming conventions;
- наладить versioning и traceability.

### Продвинутый уровень

- использовать diagrams-as-code в CI/CD;
- синхронизировать модели с требованиями и архитектурой;
- управлять репозиторием архитектурных артефактов на уровне программы.

## Расширенное сравнение инструментов

| Инструмент | Нотации | Формат работы | Совместная работа | Лицензия | Когда выбирать |
| --- | --- | --- | --- | --- | --- |
| PlantUML | UML, C4, ER-like, sequence/activity/class/state | text-as-code | через Git/PR | OSS | нужны версионирование и code review |
| Mermaid | flowchart, sequence, class, ER, C4-like | text-as-code | через Git/PR | OSS | markdown-first документация |
| draw.io (diagrams.net) | UML, BPMN-like, C4-like, ERD | visual | cloud/local файлы | free | быстрые схемы и воркшопы |
| Lucidchart | UML, BPMN, ERD, org/process | visual cloud | сильная коллаборация | commercial | распределенные команды и live-collab |
| Microsoft Visio | UML/BPMN/процессные схемы | visual desktop/cloud | M365 collaboration | commercial | enterprise на Microsoft stack |
| Visual Paradigm | UML, BPMN, ArchiMate, ERD | visual + repository | team repository | commercial | полный SDLC modeling |
| MagicDraw (Cameo) | UML/SysML/BPMN | enterprise modeling | strong governance | commercial | сложные инженерные системы |
| Enterprise Architect / Pro Cloud | UML/BPMN/ArchiMate/TOGAF | repository-based | enterprise collaboration | commercial | архитектурный репозиторий |
| Camunda Modeler | BPMN, DMN | visual | file-based + Git | free | исполняемые процессы |

## PlantUML vs Mermaid

| Критерий | PlantUML | Mermaid |
| --- | --- | --- |
| Богатство UML | выше | среднее |
| Простота для markdown | средняя | высокая |
| C4/архитектурные шаблоны | сильные | базовые |
| CI/CD интеграция | сильная | сильная |
| Порог входа | выше | ниже |

## Короткие сценарии использования

### PlantUML: context + class диаграммы

1. Создать `*.md` с блоком `kroki-plantuml`.
2. Сохранить рядом с требованиями в Git.
3. Проводить review через PR.

```kroki-plantuml
skinparam monochrome true
actor User
rectangle Web
rectangle API
database DB
User --> Web
Web --> API
API --> DB
```

### draw.io: быстрый воркшоп

1. Открыть шаблон контекст-диаграммы.
2. Добавить участников и ключевые потоки.
3. Экспортировать SVG/PDF и прикрепить в Confluence.
4. Сохранить `.drawio` в репозиторий.

### Visual Paradigm/MagicDraw/EA: enterprise-модель

1. Создать проект/репозиторий модели.
2. Настроить метамодель и стандарты именования.
3. Построить слой бизнеса, приложений и технологий.
4. Запустить регулярный review модели.

## Интеграция с Git и CI/CD

- text-as-code (PlantUML/Mermaid): хранить в Git, проверять в PR;
- visual-файлы (`.drawio`, `.vsdx`): хранить исходники + экспортированные SVG;
- CI-проверки: lint, build docs, проверка ссылок/структуры артефактов.

## Рекомендации выбора

| Контекст | Рекомендуемый подход |
| --- | --- |
| Нужен audit trail и diff | PlantUML/Mermaid |
| Нужен быстрый визуальный воркшоп | draw.io/Lucidchart |
| Нужен enterprise repository | EA/MagicDraw/Visual Paradigm |
| Сильная связь с Jira/Confluence | draw.io + Atlassian плагины или PlantUML + Markdown |

## Плагины и настройки

- VS Code: `PlantUML` extension + preview + export;
- Browser/Atlassian: diagrams.net plugin, plantuml macro;
- Git hooks: проверка именования файлов и расположения артефактов;
- стандарты: единые цвета и легенды для процессов/данных/интеграций.

## Шаблоны артефактов

### Context diagram checklist

- граница системы;
- внешние акторы;
- основные потоки данных;
- ограничения и предположения.

### Class diagram checklist

- ключевые сущности и связи;
- кардинальности;
- бизнес-правила (инварианты);
- связь с требованиями/AC.

## Связь с требованиями и процессом

- требования: моделирование помогает уточнять границы системы и сценарии;
- архитектура: C4/UML фиксируют решения и зависимости;
- разработка: diagram review снижает риск неверной реализации;
- эксплуатация: диаграммы помогают в RCA и изменениях.

## Зависимость от методологии и архитектуры

- Agile: быстрые итеративные схемы + text-as-code для частых изменений.
- Waterfall: формальные версии моделей и контроль baseline.
- Микросервисы: приоритет C4/sequence/integration схем.
- Process-heavy контур: приоритет BPMN/DMN и сквозная трассировка решений.

## Кросс-ссылки

- [Нотации и моделирование](../notations/index.md)
- [Проектирование и архитектура](../architecture/index.md)
- [Требования: Структурирование](../requirements/structuring.md)

## Типичные ошибки

- смешение уровней абстракции в одной схеме;
- отсутствие owner у модели;
- хранение только экспортированных картинок без исходника;
- отсутствие связи диаграммы с требованием/решением.
## Источники

- PlantUML: <https://plantuml.com/>
- Mermaid: <https://mermaid.js.org/>
- diagrams.net: <https://www.diagrams.net/>
- Lucidchart: <https://www.lucidchart.com/>
- Visual Paradigm: <https://www.visual-paradigm.com/>
- MagicDraw/Cameo: <https://docs.nomagic.com/>
- Enterprise Architect: <https://sparxsystems.com/products/ea/>

## Актуализация

- обновляйте шаблоны диаграмм и стиль-гайд по мере роста архитектуры;
- проверяйте совместимость плагинов IDE/Confluence после обновлений.
