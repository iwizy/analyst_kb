# ERD

ERD (Entity-Relationship Diagram) описывает структуру данных: сущности,
атрибуты и связи между ними. Для аналитика ERD - основа обсуждения модели
хранения данных, ограничений целостности и последующей реализации БД.

## Базовые элементы

- Entity (сущность): объект предметной области (`User`, `Order`).
- Attribute (атрибут): свойства сущности (`email`, `status`).
- Primary Key (PK): уникальный идентификатор записи.
- Foreign Key (FK): ссылка на PK другой сущности.
- Relationship (связь): правила кратности между сущностями.

## Типы связей

- `1:1` - один к одному (например, `User` и `UserProfile`).
- `1:M` - один ко многим (`User` и `Order`).
- `M:N` - многие ко многим через промежуточную сущность (`Student`, `Course`, `Enrollment`).

## Пример 1: пользователь и заказы (1:M)

```kroki-plantuml
@startuml
hide circle

entity USER {
  *id : bigint <<PK>>
  --
  name : text
  email : text
}

entity "ORDER" as ORDER_ENTITY {
  *id : bigint <<PK>>
  --
  created_at : timestamptz
  user_id : bigint <<FK>>
}

USER ||--o{ ORDER_ENTITY : places
@enduml
```

Практический вывод: удаление пользователя должно учитывать зависимые заказы
(`RESTRICT`, `CASCADE` или soft delete по политике домена).

## Пример 2: студенты и курсы (M:N)

```kroki-plantuml
@startuml
hide circle

entity STUDENT {
  *id : bigint <<PK>>
  --
  name : text
}

entity COURSE {
  *id : bigint <<PK>>
  --
  title : text
}

entity ENROLLMENT {
  *id : bigint <<PK>>
  --
  student_id : bigint <<FK>>
  course_id : bigint <<FK>>
  enrolled_at : timestamptz
}

STUDENT ||--o{ ENROLLMENT : enrolls
COURSE ||--o{ ENROLLMENT : includes
@enduml
```

## Минимальный SQL-каркас

```sql
create table users (
  id bigint primary key,
  email text not null unique
);

create table orders (
  id bigint primary key,
  user_id bigint not null references users(id),
  created_at timestamptz not null
);
```

## Как строить ERD

1. Соберите список бизнес-объектов и их идентификаторов.
1. Разведите мастер-данные и транзакционные данные.
1. Зафиксируйте кратности и обязательность связей.
1. Добавьте ограничения целостности и правила удаления.
1. Проверьте модель на типовых запросах и отчетах.

## Типичные ошибки

- хранение нескольких сущностей в одной таблице;
- отсутствие явных ключей и уникальных ограничений;
- связь M:N без промежуточной таблицы;
- "техническая" ERD без бизнес-терминов.

## Чек-лист качества

- Каждая сущность имеет PK и осмысленное имя.
- Кратности отражают реальные бизнес-правила.
- Модель поддерживает ключевые сценарии чтения/записи без противоречий.
