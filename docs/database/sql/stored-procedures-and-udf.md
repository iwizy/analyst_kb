# Хранимые процедуры и пользовательские функции

Процедуры и UDF полезны для локальной логики рядом с данными, но требуют строгой дисциплины versioning и тестирования.

## Уровни сложности

### Базовый

- различия procedure/function/trigger;
- side effects и транзакционные границы.

### Средний

- deterministic/idempotent функции;
- контракт функции и тесты.

### Продвинутый

- CI/CD и rollback/roll-forward для SQL-артефактов;
- сравнение платформ PostgreSQL/Oracle/MySQL.

## Сравнение платформ

| Платформа | Подход | Плюсы | Риски |
| --- | --- | --- | --- |
| PostgreSQL | PL/pgSQL, SQL | гибкость, интеграция | риск business logic creep |
| Oracle | PL/SQL packages | зрелые enterprise практики | vendor lock-in |
| MySQL | stored routines | простота | ограниченный tooling |

## Пример функции

```sql
CREATE OR REPLACE FUNCTION calc_discount(sum_amount numeric)
RETURNS numeric AS $$
BEGIN
  IF sum_amount >= 10000 THEN
    RETURN sum_amount * 0.1;
  END IF;
  RETURN 0;
END;
$$ LANGUAGE plpgsql;
```

## CI/CD практика

1. Хранить процедуры в git как versioned migrations.
2. Проверять синтаксис и unit-tests в CI.
3. Катить изменения staged rollout.
4. Иметь план rollback/roll-forward.

## Типовые ошибки

- дублирование логики в БД и приложении;
- процедуры без version control;
- отсутствие тестов на edge-cases;
- неконтролируемые side effects.

## Практические рекомендации

1. Держите в БД только логику, выигрывающую от близости к данным.
2. Документируйте контракт функции и SLA выполнения.
3. Мониторьте runtime и error rate процедур.
4. Регулярно пересматривайте необходимость каждой процедуры.

## Упражнения

1. Напишите UDF классификации клиента по обороту.
2. Добавьте тесты на граничные условия.
3. Опишите rollout-план изменения функции.

## Контрольные вопросы

1. Почему эта логика должна выполняться в БД?
2. Как обеспечено версионирование и деплой?
3. Какие метрики качества процедуры вы мониторите?

## Чек-лист самопроверки

- контракт процедуры зафиксирован;
- артефакт версионируется и тестируется;
- rollout/rollback план документирован;
- есть мониторинг длительности и ошибок.

## Стандарты и источники

- PostgreSQL PL/pgSQL: <https://www.postgresql.org/docs/current/plpgsql.html>
- Oracle docs: <https://docs.oracle.com/en/database/oracle/oracle-database/>
- MySQL stored programs: <https://dev.mysql.com/doc/refman/en/stored-programs-defining.html>
