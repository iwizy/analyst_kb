# PlantUML

> Глоссарий терминов и сокращений: [Открыть](../glossary.md)


PlantUML - текстовый язык для построения диаграмм. Для системного аналитика это
удобный формат, чтобы хранить схемы рядом с требованиями, быстро обновлять их и
прозрачно ревьюить изменения.

## Краткая база

### Минимальная структура

```kroki-plantuml
@startuml
actor User
participant API
User -> API : request
API --> User : response
@enduml
```

### Синтаксическая шпаргалка

- блок диаграммы: `@start...` / `@end...`;
- комментарий: `' текст`;
- псевдоним элемента: `"Long Name" as LN`;
- подпись связи: `A -> B : message`;
- заметки: `note right of A: text`;
- группировки: `package`, `rectangle`, `frame`;
- ветвления и циклы: `alt/else/end`, `opt/end`, `loop/end`, `par/end`;
- нумерация шагов: `autonumber`.

### Базовые принципы качества

- одна диаграмма отвечает на один вопрос;
- единая терминология с требованиями и контрактами;
- читаемые имена без `service1/module2`;
- критичные альтернативы и ошибки отражены явно.

## Галерея примеров по типам диаграмм

### UML

#### Sequence

```kroki-plantuml
@startuml
autonumber
actor User
participant Web
participant API
User -> Web : submit
Web -> API : POST /orders
API --> Web : 201
Web --> User : success
@enduml
```

#### Use Case

```kroki-plantuml
@startuml
left to right direction
actor Customer
usecase "Place order" as UC1
usecase "Track order" as UC2
Customer --> UC1
Customer --> UC2
@enduml
```

#### Class

```kroki-plantuml
@startuml
class Order {
  +id
  +status
  +submit()
}
class PaymentService {
  +authorize(order)
}
Order --> PaymentService
@enduml
```

#### Object

```kroki-plantuml
@startuml
object order1 {
  id = 1001
  status = NEW
}
object payment1 {
  method = card
}
order1 --> payment1
@enduml
```

#### Activity

```kroki-plantuml
@startuml
start
:Create request;
if (Valid?) then (Yes)
  :Process;
else (No)
  :Reject;
endif
stop
@enduml
```

#### Component

```kroki-plantuml
@startuml
component "Web" as Web
component "API" as API
database "DB" as DB
Web --> API
API --> DB
@enduml
```

#### Deployment

```kroki-plantuml
@startuml
node "K8s Cluster" {
  node "Pod A" {
    artifact "api.jar"
  }
}
database "PostgreSQL" as DB
"api.jar" --> DB
@enduml
```

#### State Machine

```kroki-plantuml
@startuml
[*] --> Draft
Draft --> Approved : approve
Approved --> Closed : close
Closed --> [*]
@enduml
```

#### Timing

```kroki-plantuml
@startuml
robust "API" as API
concise "Client" as C
@0
API is Idle
C is Waiting
@5
API is Busy
C is Waiting
@10
API is Idle
C is Done
@enduml
```

### Данные и архитектура

#### ER (IE / crow's foot)

```kroki-plantuml
@startuml
entity "customers" as customers {
  *id : bigint <<PK>>
  --
  *email : varchar(255)
}
entity "orders" as orders {
  *id : bigint <<PK>>
  --
  *customer_id : bigint <<FK>>
}
customers ||--o{ orders
@enduml
```

#### ER (Chen)

```kroki-plantuml
@startchen
entity CUSTOMER {
  name
}
entity ORDER {
  number
}
relationship PLACES {
}
CUSTOMER -N- PLACES
PLACES -1- ORDER
@endchen
```

#### ArchiMate

```kroki-plantuml
@startuml
!include <archimate/Archimate>
Business_Actor(customer, "Customer")
Business_Process(onboarding, "Onboarding")
Application_Component(app, "Onboarding App")
Rel_Assignment(customer, onboarding)
Rel_Serving(app, onboarding)
@enduml
```

#### Network (nwdiag)

```kroki-plantuml
@startnwdiag
nwdiag {
  network dmz {
    web01;
    web02;
  }
  network internal {
    app01;
    db01;
    app01 -- db01;
  }
}
@endnwdiag
```

### Планирование и структура

#### Gantt

```kroki-plantuml
@startgantt
Project starts 2026-02-01
[Analysis] lasts 5 days
[Build] lasts 7 days
[Build] starts at [Analysis]'s end
@endgantt
```

#### MindMap

```kroki-plantuml
@startmindmap
* Product
** Requirements
** Architecture
** Release
@endmindmap
```

#### WBS

```kroki-plantuml
@startwbs
* Program
** Analysis
*** Interviews
*** Models
** Delivery
*** Build
*** Test
@endwbs
```

### Текстовые и формальные нотации

#### SALT (Wireframe)

```kroki-plantuml
@startsalt
{
  + Login form
  User name | "john"
  Password  | "****"
  [Submit] [Cancel]
}
@endsalt
```

#### Ditaa

```kroki-plantuml
@startditaa
+--------+   +--------+
| Client |-->| Server |
+--------+   +--------+
@endditaa
```

#### EBNF

```kroki-plantuml
@startebnf
expression = term , { ("+" | "-") , term } ;
term = factor , { ("*" | "/") , factor } ;
factor = number | "(" , expression , ")" ;
@endebnf
```

#### Regex

```kroki-plantuml
@startregex
^([A-Z]{3})-(\\d{4})$
@endregex
```

### Структуры данных и графики

#### JSON

```kroki-plantuml
@startjson
{
  "orderId": 1001,
  "status": "NEW",
  "items": ["A", "B"]
}
@endjson
```

#### YAML

```kroki-plantuml
@startyaml
order:
  id: 1001
  status: NEW
  items:
    - A
    - B
@endyaml
```

#### Chart

```kroki-plantuml
@startchart
bar
"Q1" 10
"Q2" 15
"Q3" 7
@endchart
```

## Практика использования в аналитике

- прикладывайте диаграмму к конкретной user story/требованию;
- фиксируйте версию схемы в том же изменении, где меняется логика;
- держите отдельные схемы для бизнес-потока, интеграций и данных;
- используйте диаграммы как обязательный артефакт на уточнении и приемке.

## Частые ошибки

- перегруженные схемы с несколькими уровнями абстракции;
- устаревшие диаграммы после изменения API или модели данных;
- отсутствие связки между схемой и конкретным требованием;
- неявные условия ошибок и отказов в критичных сценариях.

## Чек-лист перед публикацией

- Диаграмма отвечает на конкретный вопрос.
- Имена и статусы совпадают с требованиями.
- Схема читается без устных пояснений.
- Альтернативные/ошибочные ветки отражены при необходимости.
- Диаграмма актуальна к последним изменениям.

## Смежные материалы

- [UML](../notations/uml/index.md)
- [Sequence](../notations/uml/sequence.md)
- [Class](../notations/uml/class.md)
- [ERD](../notations/erd.md)
- [C4](../notations/c4.md)
- [Archimate](../notations/archimate.md)
- [Draw.io](drawio.md)

## Практическое дополнение

- Определите owner инструмента в команде и минимальный стандарт использования.
- Зафиксируйте шаблон артефакта, который создается в инструменте, и связь с backlog.
- Введите ежемесячную ревизию актуальности артефактов, чтобы не накапливать устаревший контент.
