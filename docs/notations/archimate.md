# Archimate

> Глоссарий терминов и сокращений: [Открыть](../glossary.md)


Archimate — стандарт enterprise architecture моделирования от Open Group. Покрывает бизнес-, приложенческий и технологический слои, а также мотивацию и стратегию.

## Уровни сложности

### Базовый уровень

- понимать слои Business/Application/Technology;
- читать базовые элементы и связи;
- строить обзорные диаграммы целевой архитектуры.

### Средний уровень

- моделировать мотивацию, capability и value stream;
- связывать приложения с технологической инфраструктурой;
- применять viewpoints под аудиторию.

### Продвинутый уровень

- строить repository enterprise architecture;
- использовать plateaus/gaps/roadmap для трансформации;
- интегрировать Archimate с TOGAF governance.

## Слои и аспекты

| Слой | Что описывает |
| --- | --- |
| Business | процессы, роли, бизнес-сервисы |
| Application | приложения, компоненты, интерфейсы |
| Technology | инфраструктура, узлы, сети, системное ПО |

| Сквозные аспекты | Назначение |
| --- | --- |
| Motivation | цели, драйверы, требования |
| Strategy | capability, ресурсы, value stream |
| Implementation & Migration | roadmap, plateaus, work packages |

## Пример: приложение и технология

```kroki-plantuml
@startuml
left to right direction
rectangle "Business Process\nОформление заказа" as BP
rectangle "Application Service\nOrder API" as AS
rectangle "Application Component\nOrder Service" as AC
rectangle "Technology Node\nKubernetes Cluster" as TN
database "Technology Service\nPostgreSQL" as DB

BP --> AS : uses
AS --> AC : realized by
AC --> TN : deployed on
AC --> DB : stores data
@enduml
```

## Плюсы и минусы

| Плюсы | Минусы |
| --- | --- |
| сквозная EA-модель от стратегии до технологий | высокий порог входа |
| единый язык для архитектурного governance | требует методической дисциплины |
| хорошо работает с TOGAF и roadmap | избыточен для маленьких систем |

## Где применять

- enterprise architecture и целевые ландшафты;
- программы трансформации, миграции legacy;
- согласование бизнес-целей и IT-реализации.

## Как строить

1. Выберите viewpoint (например, Application Cooperation).
2. Определите scope и уровень абстракции.
3. Добавьте элементы слоя и связи.
4. Сопоставьте с требованиями и capability.
5. Зафиксируйте owners, roadmap и ограничения.

## Типичные ошибки и как избежать

| Ошибка | Как избежать |
| --- | --- |
| смешение всех слоев в одной схеме | выбирайте один viewpoint на диаграмму |
| избыточное число элементов | оставляйте только решения текущего вопроса |
| нет связи с целями | добавляйте motivation elements |
| устаревшие технологические связи | введите регулярный архитектурный review |

## Инструменты и форматы

- Archi, BizzDesign, Sparx EA, draw.io;
- экспорт: SVG/PNG/PDF, Archimate exchange format.
## Стандарты и источники

- Archimate 3.2: <https://pubs.opengroup.org/architecture/archimate3-doc/>
- TOGAF Standard: <https://www.opengroup.org/togaf>
- Archi tool: <https://www.archimatetool.com/>
