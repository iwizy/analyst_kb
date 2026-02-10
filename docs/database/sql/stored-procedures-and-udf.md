# Хранимые процедуры и пользовательские функции

Процедуры и [UDF](../../glossary.md#abbr-090) полезны для локальной логики рядом с данными, но требуют строгой дисциплины versioning и тестирования.

## Уровни сложности

### Базовый

- различия procedure/function/trigger;
- side effects и транзакционные границы.

### Средний

- deterministic/idempotent функции;
- контракт функции и тесты.

### Продвинутый

- [[CI](../../glossary.md#abbr-016)/CD](../../glossary.md#abbr-017) и rollback/roll-forward для [SQL](../../glossary.md#abbr-084)-артефактов;
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

## [[CI](../../glossary.md#abbr-016)/CD](../../glossary.md#abbr-017) практика

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
2. Документируйте контракт функции и [SLA](../../glossary.md#abbr-079) выполнения.
3. Мониторьте runtime и error rate процедур.
4. Регулярно пересматривайте необходимость каждой процедуры.

## Упражнения

1. Напишите [UDF](../../glossary.md#abbr-090) классификации клиента по обороту.
2. Добавьте тесты на граничные условия.
3. Опишите rollout-план изменения функции.
## Стандарты и источники

- PostgreSQL PL/pgSQL: <https://www.postgresql.org/docs/current/plpgsql.html>
- Oracle docs: <https://docs.oracle.com/en/database/oracle/oracle-database/>
- MySQL stored programs: <https://dev.mysql.com/doc/refman/en/stored-programs-defining.html>
