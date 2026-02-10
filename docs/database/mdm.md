# Master Data Management ([MDM](../glossary.md#abbr-049))

MDM обеспечивает единые, согласованные и управляемые мастер-данные (клиент, продукт, контрагент) для всех систем компании.

## Уровни сложности

### Базовый

- понимать цель Golden Record;
- различать модели внедрения MDM.

### Средний

- проектировать matching, survivorship и stewardship процессы;
- выбирать инструмент MDM под контур компании.

### Продвинутый

- строить MDM как платформенную capability с [KPI](../glossary.md#abbr-047) качества;
- синхронизировать MDM с Data Governance и операционными системами.

## Модели MDM

| Модель | Описание | Когда подходит |
| --- | --- | --- |
| Registry | ссылки на записи из источников, без полного копирования | быстрый старт |
| Consolidation | собирает и очищает данные в hub | аналитика и качество |
| Coexistence | hub + обратная синхронизация в источники | поэтапная трансформация |
| Centralized | MDM как основной источник master-data | зрелый enterprise контур |

## Этапы внедрения

1. Выбрать критичные домены (`Customer`, `Product`, `Supplier`).
2. Определить источники и правила доверия.
3. Настроить matching и survivorship.
4. Внедрить stewardship workflow.
5. Запустить синхронизацию Golden Record в потребители.

## Data matching и survivorship

| Метод | Пример |
| --- | --- |
| Exact match | ИНН/регистрационный номер |
| Fuzzy match | похожие ФИО, адреса, email |
| Probabilistic | итоговый score из нескольких полей |

Пример survivorship:

- email брать из CRM, если `verified=true`;
- телефон брать из billing, если обновлен не старше 30 дней;
- конфликт адреса отправлять в stewardship queue.

## Инструменты

- Informatica MDM
- Talend Data Fabric
- Semarchy xDM
- Ataccama ONE

## KPI качества MDM

- duplicate rate;
- completeness score;
- Golden Record sync latency;
- stewardship cycle time;
- data issue reopen rate.

## Типовые ошибки

- попытка покрыть все домены с первого релиза;
- отсутствие ownership и stewardship ролей;
- неформализованные survivorship rules;
- отсутствие интеграции MDM с operational workflow.

## Практические рекомендации

1. Начинайте с 1-2 доменов с наибольшим бизнес-эффектом.
2. Фиксируйте правила matching/survivorship как versioned policies.
3. Внедрите stewardship [SLA](../glossary.md#abbr-079) и KPI.
4. Интегрируйте MDM события через [CDC](../glossary.md#abbr-014)/event bus.
## Стандарты и источники

- DAMA-DMBOK: <https://www.dama.org/content/body-knowledge>
- Informatica MDM docs: <https://docs.informatica.com/master-data-management.html>
- Semarchy docs: <https://www.semarchy.com/doc/>
