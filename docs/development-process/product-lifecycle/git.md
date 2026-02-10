# Git в жизненном цикле разработки

Git обеспечивает управляемость изменений, прозрачность решений и воспроизводимость поставки. Для аналитика это критично для трассировки: требование -> изменение -> тест -> релиз.

## Уровни сложности

### Базовый уровень

- понимать commit, branch, merge, tag;
- читать историю изменений по задаче;
- участвовать в PR-review с фокусом на требования и [AC](../../glossary.md#abbr-002).

### Средний уровень

- выбирать подход к ветвлению (trunk-based, GitFlow, release branches);
- связывать изменения с требованиями и дефектами;
- поддерживать release notes и change log.

### Продвинутый уровень

- выстраивать multi-team strategy по релизам;
- интегрировать Git-процесс с [[CI](../../glossary.md#abbr-016)/CD](../../glossary.md#abbr-017), compliance и audit;
- управлять рисками cherry-pick/hotfix/release train.

## Базовые сущности

| Сущность | Назначение |
| --- | --- |
| Commit | атомарное изменение с контекстом |
| Branch | изолированная линия работ |
| Pull Request | формальный канал review и quality gates |
| Tag | фиксирует релизную версию |

## Стратегии ветвления

| Стратегия | Плюсы | Ограничения |
| --- | --- | --- |
| Trunk-based | быстрые интеграции, меньше конфликтов | требует сильной автоматизации |
| GitFlow | удобна для длинных релизных циклов | высокая сложность и overhead |
| Release branches | гибкость hotfix и долгой поддержки | риск расхождения веток |

## Схема типового потока

```kroki-plantuml
skinparam monochrome true
left to right direction
actor Analyst as A
rectangle "main" as M
rectangle "feature/REQ-124" as F
rectangle "release/2.4" as R
A --> F : уточнение требований и AC
M --> F : branch
F --> M : PR + checks
M --> R : release cut
```

## Рекомендации по коммитам и PR

- один коммит/PR = одна логическая цель;
- в PR указывать ссылку на требование/дефект;
- фиксировать влияние на [NFR](../../glossary.md#abbr-053) и миграции данных;
- добавлять тестовые доказательства в описание PR.

## Типовые ошибки

- крупные PR без декомпозиции и понятного контекста;
- долгоживущие feature-ветки;
- merge без обязательных проверок;
- несогласованные hotfix в обход процесса.## Стандарты и источники

- Pro Git Book: <https://git-scm.com/book/en/v2>
- Conventional Commits: <https://www.conventionalcommits.org/en/v1.0.0/>
- GitHub pull requests: <https://docs.github.com/pull-requests>
