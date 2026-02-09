# PlantUML

PlantUML - язык описания диаграмм в текстовом формате. Для системного аналитика
это рабочий инструмент, который помогает держать модели рядом с требованиями,
быстро вносить изменения и обсуждать решения с командой в одном артефакте.

## Зачем это системному аналитику

- быстро моделировать сценарии взаимодействий и спорные точки процесса;
- формализовывать структуру данных и связи между сущностями;
- синхронизировать бизнес- и технические термины в одном представлении;
- упрощать ревью изменений: текст диаграммы читается как обычный diff.

## Базовые правила синтаксиса

### Каркас любой диаграммы

```kroki-plantuml
@startuml
' комментарий
actor "Пользователь" as User
participant "API" as API
User -> API : Запрос
API --> User : Ответ
@enduml
```

### Ключевые элементы языка

- объявления: `actor`, `participant`, `database`, `entity`, `component`, `node`;
- связи: `->`, `-->`, подпись после `:`;
- ветвления: `alt / else / end`, `opt / end`, `loop / end`, `par / end`;
- заметки: `note right of`, `note left of`, `note over`;
- форматирование: `title`, `legend`, `skinparam`, `<style>`.

### Универсальные рекомендации

- одна диаграмма = один вопрос, который она объясняет;
- стабильный уровень детализации внутри одной схемы;
- термины в диаграмме должны совпадать с требованиями и контрактами;
- обязательно показывайте альтернативные/ошибочные ветки в критичных сценариях.

## Полный каталог диаграмм PlantUML

Ниже перечислены все ключевые типы диаграмм, которые поддерживает PlantUML на
практике для аналитической и инженерной документации.

### UML-диаграммы

| Тип | Для чего использовать | Базовый старт |
| --- | --- | --- |
| Sequence | взаимодействия во времени, API и интеграции | `@startuml` |
| Use Case | границы функциональности и роли пользователей | `@startuml` |
| Class | модель классов, атрибутов, зависимостей | `@startuml` |
| Object | снимок объектов и их связей в конкретный момент | `@startuml` |
| Activity | поток шагов и условия переходов | `@startuml` |
| Component | состав системы и связи между компонентами | `@startuml` |
| Deployment | размещение артефактов по узлам инфраструктуры | `@startuml` |
| State Machine | состояния объекта и переходы | `@startuml` |
| Timing | временная шкала и изменение состояния сигналов | `@startuml` |

### Не-UML диаграммы и нотации

| Тип | Для чего использовать | Базовый старт |
| --- | --- | --- |
| ER (Information Engineering, crow's foot) | логическая модель таблиц, PK/FK, кардинальности | `@startuml` |
| ER (Chen / EER) | концептуальная ER-модель (сущности, атрибуты, связи) | `@startchen` |
| ArchiMate | enterprise-архитектура: бизнес, приложения, технология | `@startuml` |
| Network (nwdiag) | сетевые сегменты и связи узлов | `@startnwdiag` |
| Wireframe (SALT) | простые UI-макеты и формы | `@startsalt` |
| SDL | событийные/сигнальные модели (Specification and Description Language) | `@startsdl` |
| Ditaa | ASCII-эскизы блок-схем | `@startditaa` |
| Gantt | сроки, зависимости, дорожные карты | `@startgantt` |
| Chronology | временная линия событий | `@startchronology` |
| MindMap | иерархия идей и декомпозиция тем | `@startmindmap` |
| WBS | структура работ (Work Breakdown Structure) | `@startwbs` |
| EBNF | описание грамматик и синтаксиса | `@startebnf` |
| Regex | визуализация регулярных выражений | `@startregex` |
| JSON data | визуализация структуры JSON | `@startjson` |
| YAML data | визуализация структуры YAML | `@startyaml` |
| Chart | графики (bar/line/area/scatter и др.) | `@startchart` |
| Mathematics (AsciiMath/JLaTeXMath) | формулы и математические выражения в схемах | `@startuml` |

### Дополнительно через библиотеки/расширения

- C4-представления (Context/Container/Component/Code) через C4-библиотеки;
- BPMN-подобные схемы через пользовательские библиотеки и макросы;
- доменные шаблоны (например, security, cloud, enterprise) через include-наборы.

## Sequence: базовый синтаксис и практическая шпаргалка

Sequence показывает, кто, кому и в какой последовательности отправляет сообщения.

### Участники

- `actor` - внешний пользователь/роль;
- `participant` - сервис, модуль, gateway;
- `database` - БД/хранилище;
- `queue` - брокер/очередь событий.

```kroki-plantuml
@startuml
actor User
participant Web
participant API
database DB
queue MQ

User -> Web : submit form
Web -> API : POST /orders
API -> DB : insert order
API -> MQ : publish OrderCreated
API --> Web : 201 Created
Web --> User : Заказ принят
@enduml
```

### Вызовы, ответы, активация

```kroki-plantuml
@startuml
autonumber
actor Client
participant Auth
database Users

Client -> Auth : POST /login
activate Auth
Auth -> Users : findByEmail()
Users --> Auth : user
Auth --> Client : 200 token
deactivate Auth
@enduml
```

Практика:

- используйте `autonumber`, когда нужно ссылаться на шаги в требованиях;
- `activate/deactivate` удобно для длинных цепочек с блокировками;
- для ответов используйте `-->`, чтобы визуально отделять call и return.

### Ветвления и ошибки

```kroki-plantuml
@startuml
actor User
participant API
participant Risk

User -> API : POST /loan/apply
alt Валидация успешна
  API -> Risk : check(application)
  alt Риск допустим
    API --> User : 201 APPROVED
  else Риск высокий
    API --> User : 422 REJECTED
  end
else Ошибка валидации
  API --> User : 400 VALIDATION_ERROR
end
@enduml
```

### Полный практический пример: логин + MFA

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
  Web --> User : Запрос OTP
  User -> Web : Ввод OTP
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
else Пароль неверный
  Auth --> Web : 401 INVALID_CREDENTIALS
  Web --> User : Ошибка авторизации
end

deactivate Auth
@enduml
```

### Частые ошибки в sequence

- смешение бизнес-шагов и низкоуровневых сетевых деталей в одной схеме;
- отсутствие негативных веток для критичных операций;
- участники с абстрактными именами (`service1`, `moduleA`);
- схема на 20+ участников вместо декомпозиции по сценариям.

## ERD: базовый синтаксис и практическая шпаргалка

Для рабочих моделей БД чаще используется IE-подход (`entity` + кардинальности).
Для концептуального моделирования можно применять Chen-нотацию.

### IE-стиль (логическая модель)

```kroki-plantuml
@startuml
entity "customers" as customers {
  *id : bigint <<PK>>
  --
  *email : varchar(255) <<UQ>>
  full_name : varchar(255)
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

### Кардинальности (минимум для чтения)

- `|` - ровно один;
- `o` - ноль (опционально);
- `{` - много.

Примеры:

- `A ||--|| B` - 1:1;
- `A ||--o{ B` - 1:0..*;
- `A o|--|| B` - 0..1:1.

### Полный практический пример ERD

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

### Chen-стиль (концептуальный ER)

Используется для концептуальной модели предметной области, когда важно
обсудить сущности и бизнес-связи до физической структуры таблиц.

```kroki-plantuml
@startchen
entity CUSTOMER {
  name
  email
}
entity ORDER {
  number
  created_at
}
relationship PLACES {
}
CUSTOMER -N- PLACES
PLACES -1- ORDER
@endchen
```

### Практика моделирования ERD для аналитика

1. Начинайте с бизнес-сущностей и их жизненного цикла.
1. Сразу фиксируйте обязательность данных и уникальные ограничения.
1. Для каждой связи указывайте кардинальность и смысл зависимости.
1. Проверяйте, что модель покрывает операции чтения, записи и отчетности.
1. Выносите технические детали индексов и партицирования в отдельные материалы.

### Частые ошибки в ERD

- нет `PK/FK`, из-за чего теряется понимание связности;
- отсутствуют кардинальности или они противоречат бизнес-правилам;
- смешение концептуальной и физической модели в одном артефакте;
- избыточная детализация полей на ранних стадиях анализа.

## Как сделать статью и диаграммы реально полезными в работе

- привязывайте каждую диаграмму к конкретному требованию/истории;
- держите версию диаграммы синхронной с контрактом API или моделью данных;
- добавляйте краткий текст: "что показывает схема" и "какое решение из нее следует";
- используйте диаграммы как вход в refinement и как материал для приемки.

## Чек-лист качества диаграммы

- Диаграмма отвечает на конкретный вопрос.
- Термины совпадают с глоссарием и требованиями.
- Для `sequence` есть альтернативы/ошибки в критичных точках.
- Для `ERD` указаны ключи и кардинальности.
- Диаграмма читается без устных пояснений и не перегружена.

## Смежные материалы

- [UML](../notations/uml/index.md)
- [Sequence](../notations/uml/sequence.md)
- [Class](../notations/uml/class.md)
- [ERD](../notations/erd.md)
- [C4](../notations/c4.md)
- [Archimate](../notations/archimate.md)
- [Draw.io](drawio.md)
