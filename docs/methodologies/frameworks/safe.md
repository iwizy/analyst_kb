# [SAFe](../../glossary.md#abbr-077) (Scaled Agile Framework)

SAFe - фреймворк масштабирования Agile на уровне программы и портфеля. Полезен, когда нужно синхронизировать множество команд и сохранять управляемость зависимостей.

## Уровни сложности

### Базовый уровень

- знать уровни SAFe и ключевые роли;
- понимать цель PI Planning;
- использовать PI Objectives и dependency board.

### Средний уровень

- синхронизировать backlog между Portfolio/Program/Team;
- управлять межкомандными рисками через ROAM;
- применять System Demo и Inspect & Adapt.

### Продвинутый уровень

- внедрять Lean Portfolio Management;
- оптимизировать flow в ART;
- сочетать SAFe с enterprise governance и compliance.

## Уровни SAFe

- Team;
- Program (ART);
- Large Solution (при необходимости);
- Portfolio.

## PI-цикл SAFe

```kroki-plantuml
skinparam monochrome true
start
:Подготовка PI;
:PI Planning;
:Итерации команд;
:System Demo;
:Inspect & Adapt;
:Обновление Program/Portfolio backlog;
stop
```

## Артефакты и роли

| Артефакт | Назначение |
| --- | --- |
| Program Backlog | список фич уровня программы |
| PI Objectives | цели команд на PI |
| Dependency Board | межкомандные зависимости |
| Program Risks (ROAM) | управление программными рисками |

| Роль | Ответственность |
| --- | --- |
| Release Train Engineer | координация ART |
| Product Management | ценность на уровне программы |
| System Architect | архитектурная согласованность |
| Product Owner | приоритеты на уровне команды |

## Шаблон PI Objectives (фрагмент)

| Team | Objective | Business Value | Status |
| --- | --- | --- | --- |
| Team A | Снизить время отклика checkout на 20% | 8/10 | Planned |

## Плюсы и ограничения

Плюсы:

- синхронизация большого количества команд;
- прозрачность зависимостей и рисков;
- единый ритм поставки на уровне программы.

Ограничения:

- высокий организационный overhead;
- риск формализма без фокуса на ценности;
- требует зрелого лидерства и дисциплины исполнения.

## Пример проекта

Крупная банковская цифровая программа с 10+ командами, общими интеграциями и жесткими сроками регуляторных изменений.

## Связь с требованиями и рисками

- требования каскадируются: Portfolio Epic -> Feature -> Story;
- изменения управляются через backlog на каждом уровне;
- program risks оцениваются и пересматриваются в PI cadence.

## Типичные ошибки

- формальный PI Planning без реального управления зависимостями;
- слишком много локальной оптимизации команд;
- отсутствие связи между portfolio-целями и sprint delivery.## Источники

- [SAFe](../../glossary.md#abbr-077) 6.0: <https://scaledagileframework.com/>
