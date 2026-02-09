# PlantUML

PlantUML - инструмент для описания диаграмм в текстовом формате. Для системного
аналитика это удобный способ держать модели рядом с требованиями, видеть изменения
в `git diff` и быстро обновлять документацию без графических редакторов.

## Для чего аналитик использует PlantUML

- описывает интеграционные сценарии и API-взаимодействия;
- фиксирует ключевые структуры данных и связи между сущностями;
- документирует бизнес- и системные потоки для обсуждения с командой;
- поддерживает архитектурные решения и технические ограничения в актуальном виде.

## Быстрый старт в этом проекте (`mkdocs` + `kroki`)

В проекте диаграммы рендерятся через `mkdocs-kroki`, поэтому в markdown
используется блок `kroki-plantuml`.

````markdown
```kroki-plantuml
@startuml
actor User
participant API
User -> API : GET /status
API --> User : 200 OK
@enduml
```
````

Минимальные правила:

- каждый блок начинается с `@startuml` и заканчивается `@enduml`;
- используйте алиасы (`as`) для длинных названий;
- диаграмма должна отвечать на один конкретный вопрос.

## Что выбрать: mini-карта диаграмм

| Задача | Рекомендуемый тип |
| --- | --- |
| Показать последовательность вызовов | Sequence |
| Показать структуру таблиц и связей данных | ERD |
| Показать поток шагов и ветвлений | Activity |
| Показать состав сервисов и контуры | Component / C4-подобный |

## Базовый синтаксис PlantUML

### Общая структура

```kroki-plantuml
@startuml
' комментарий (однострочный)
skinparam shadowing false

actor "Пользователь" as User
participant "Order API" as API
User -> API : POST /orders
API --> User : 201 Created
@enduml
```

### Часто используемые элементы

- участники: `actor`, `participant`, `database`, `queue`, `component`, `node`, `entity`;
- связи: `->`, `-->`;
- подписи связей: текст после `:`;
- блоки логики: `alt/else/end`, `opt/end`, `loop/end`, `par/end`, `group/end`;
- заметки: `note right of`, `note left of`, `note over`.

## Sequence: подробная шпаргалка

Sequence-диаграмма показывает обмен сообщениями между участниками во времени.

### 1) Минимальный каркас sequence

```kroki-plantuml
@startuml
actor Client
participant Web
participant API

Client -> Web : действие пользователя
Web -> API : HTTP-запрос
API --> Web : ответ
Web --> Client : результат
@enduml
```

### 2) Участники и их роль

- `actor`: внешний пользователь или внешняя роль;
- `participant`: сервис, модуль, адаптер;
- `database`: БД или хранилище;
- `queue`: брокер/очередь сообщений.

Рекомендуется задавать читаемые названия + короткий алиас:

```kroki-plantuml
@startuml
participant "Integration Gateway" as IG
database "Billing DB" as BDB
IG -> BDB : select invoice
@enduml
```

### 3) Сообщения, ответы, активация

```kroki-plantuml
@startuml
autonumber
actor User
participant API
database DB

User -> API : POST /login
activate API
API -> DB : findUser(email)
DB --> API : user
API --> User : 200 token
deactivate API
@enduml
```

Практика:

- `autonumber` полезен для ссылок на шаги в требованиях/дефектах;
- `activate/deactivate` помогает показать время выполнения операции;
- ответы (`-->`) добавляют читаемость, особенно в длинных сценариях.

### 4) Ветвления, опции и циклы

```kroki-plantuml
@startuml
actor User
participant API
participant Risk

User -> API : POST /loan/apply
alt обязательные поля заполнены
  API -> Risk : score(request)
  alt риск допустим
    API --> User : 201 APPROVED
  else риск высокий
    API --> User : 422 REJECTED
  end
else поля невалидны
  API --> User : 400 VALIDATION_ERROR
end
@enduml
```

### 5) Полноценный пример: авторизация + MFA

```kroki-plantuml
@startuml
autonumber
actor "Пользователь" as User
participant "Web App" as Web
participant "Auth API" as Auth
database "User DB" as UDB
participant "MFA Service" as MFA

User -> Web : Ввод логина/пароля
Web -> Auth : POST /auth/login
activate Auth
Auth -> UDB : findUser(email)
UDB --> Auth : user + password_hash

alt Пароль корректный
  Auth -> MFA : sendOtp(userId)
  MFA --> Auth : otp_sent
  Auth --> Web : 202 MFA_REQUIRED
  Web --> User : Запросить OTP
  User -> Web : Ввести OTP
  Web -> Auth : POST /auth/mfa/verify
  Auth -> MFA : verifyOtp(code)
  alt OTP валиден
    MFA --> Auth : ok
    Auth --> Web : 200 access_token
    Web --> User : Успешный вход
  else OTP невалиден
    MFA --> Auth : failed
    Auth --> Web : 401 INVALID_OTP
    Web --> User : Ошибка OTP
  end
else Пароль некорректный
  Auth --> Web : 401 INVALID_CREDENTIALS
  Web --> User : Ошибка авторизации
end

deactivate Auth
@enduml
```

### 6) Шаблон sequence (copy-paste)

````markdown
```kroki-plantuml
@startuml
autonumber
actor "<Actor>" as A
participant "<Client/System>" as C
participant "<Service>" as S
database "<DB>" as DB

A -> C : <User action>
C -> S : <Request>
S -> DB : <Read/Write>
DB --> S : <Result>
alt <Success condition>
  S --> C : <Success response>
  C --> A : <Success message>
else <Failure condition>
  S --> C : <Error response>
  C --> A : <Error message>
end
@enduml
```
````

## ERD: подробная шпаргалка

Для ERD в PlantUML обычно используют `entity` и связи с кардинальностями.

### 1) Базовый каркас ERD

```kroki-plantuml
@startuml
entity "customers" as customers {
  *id : bigint <<PK>>
  --
  *email : varchar(255) <<UQ>>
  *created_at : timestamp
}

entity "orders" as orders {
  *id : bigint <<PK>>
  --
  *customer_id : bigint <<FK>>
  *status : varchar(32)
  *created_at : timestamp
}

customers ||--o{ orders : places
@enduml
```

### 2) Как читать кардинальности

- `|` - обязательно один;
- `o` - ноль (опционально);
- `{` - много.

Примеры связей:

- `A ||--|| B` - один к одному;
- `A ||--o{ B` - один ко многим (со стороны B может быть 0..*);
- `A o|--|| B` - ноль или один к одному.

### 3) Полный пример ERD: e-commerce

```kroki-plantuml
@startuml
left to right direction
hide circle
skinparam linetype ortho

entity "customers" as customers {
  *id : bigint <<PK>>
  --
  *email : varchar(255) <<UQ>>
  full_name : varchar(255)
  *created_at : timestamp
}

entity "products" as products {
  *id : bigint <<PK>>
  --
  *sku : varchar(64) <<UQ>>
  *name : varchar(255)
  *price : numeric(12,2)
}

entity "orders" as orders {
  *id : bigint <<PK>>
  --
  *customer_id : bigint <<FK>>
  *status : varchar(32)
  *created_at : timestamp
}

entity "order_items" as order_items {
  *id : bigint <<PK>>
  --
  *order_id : bigint <<FK>>
  *product_id : bigint <<FK>>
  *qty : integer
  *unit_price : numeric(12,2)
}

entity "payments" as payments {
  *id : bigint <<PK>>
  --
  *order_id : bigint <<FK>>
  *status : varchar(32)
  provider_txn_id : varchar(128)
}

customers ||--o{ orders : places
orders ||--o{ order_items : contains
products ||--o{ order_items : referenced_by
orders ||--o{ payments : paid_by
@enduml
```

### 4) Практика моделирования ERD для аналитика

1. Сначала определите границы домена и основные сущности.
1. Зафиксируйте ключи (`PK`, `FK`) и обязательность полей.
1. Добавьте кардинальности для всех связей.
1. Проверьте, что модель покрывает реальные сценарии чтения/записи.
1. Отдельно согласуйте ограничения уникальности и справочники статусов.

### 5) Шаблон ERD (copy-paste)

````markdown
```kroki-plantuml
@startuml
left to right direction
hide circle

entity "<table_a>" as A {
  *id : bigint <<PK>>
  --
  *<field_1> : <type>
  <field_2> : <type>
}

entity "<table_b>" as B {
  *id : bigint <<PK>>
  --
  *a_id : bigint <<FK>>
}

A ||--o{ B : <relation_name>
@enduml
```
````

## Стандарты оформления внутри команды

- используйте единый язык диаграмм (рус/англ без смешения в одной модели);
- имена участников/таблиц должны совпадать с требованиями и API/DB контрактами;
- не смешивайте бизнес-уровень и инфраструктурные детали в одном изображении;
- одна диаграмма - одна цель, дополнительные детали выносите в отдельные схемы.

## Лучшие практики для системного аналитика

- храните диаграмму рядом с требованием, которое она поясняет;
- в тексте статьи/задачи явно указывайте, на какой вопрос отвечает схема;
- добавляйте минимум один альтернативный или ошибочный сценарий;
- регулярно синхронизируйте диаграммы после изменения API/данных;
- используйте диаграммы как материал для уточнения требований на grooming/refinement.

## Анти-паттерны

- диаграмма как "картинка для презентации" без инженерной пользы;
- абстрактные названия (`Service1`, `TableX`) без доменного смысла;
- отсутствие ошибок, таймаутов, отказов в sequence-критичных потоках;
- ERD без кардинальностей и без явных ключей.

## Частые ошибки и как исправлять

| Проблема | Причина | Что делать |
| --- | --- | --- |
| Диаграмма не рендерится | синтаксическая ошибка/не закрыт блок | проверить `@startuml/@enduml`, `alt/end`, `loop/end` |
| Трудно читать sequence | слишком много участников и сообщений | делить по use-case, оставлять один сценарий на диаграмму |
| Неясна модель данных | нет кардинальностей и ключей | добавить `PK/FK`, явно указать тип связи |
| Термины расходятся с требованиями | разный словарь у команд | сверить с глоссарием и контрактами |

## Чек-лист перед публикацией диаграммы

- Диаграмма отвечает на конкретный вопрос и имеет контекст.
- Термины совпадают с требованиями и договоренностями команды.
- Для `sequence` отражены альтернативы/ошибки в критичных точках.
- Для `ERD` указаны `PK/FK` и кардинальности связей.
- Диаграмма рендерится в `mkdocs` без ошибок.

## Смежные материалы

- [UML](../notations/uml/index.md)
- [Sequence](../notations/uml/sequence.md)
- [Class](../notations/uml/class.md)
- [ERD](../notations/erd.md)
- [C4](../notations/c4.md)
- [Draw.io](drawio.md)
