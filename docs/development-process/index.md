# Процесс разработки

Раздел описывает полный жизненный цикл ПО: от инициации до эксплуатации и улучшений. Материал ориентирован на роль аналитика как связующего звена между бизнесом, продуктом и delivery-командой.

## Что входит в путеводитель

- фазы SDLC и артефакты каждого этапа;
- Agile-процессы (Scrum, Kanban, SAFe, Lean);
- DevOps-практики (CI/CD, IaC, мониторинг);
- гибридные модели (включая Water-Scrum-Fall);
- управление качеством, документацией и рисками.

## Жизненный цикл ПО: фазы и артефакты

| Фаза | Ключевые активности | Артефакты |
| --- | --- | --- |
| Инициация | Формирование целей и бизнес-обоснования | Vision, business case, high-level scope |
| Анализ | Сбор и уточнение требований | BRD/SRS, backlog, модели процессов |
| Дизайн | Архитектурное и UX-проектирование | C4/UML/BPMN, API contracts, прототипы |
| Разработка | Реализация и code review | Код, unit tests, technical docs |
| Тестирование | Проверка качества и приемка | Test cases, тест-отчеты, bug log |
| Развертывание | Выпуск в окружения | Release plan, runbook, rollback plan |
| Эксплуатация | Мониторинг и поддержка | SLI/SLO, incident reports, improvements backlog |

## Agile, DevOps и гибриды

### Agile

- Scrum: роли, церемонии, артефакты, Definition of Done;
- Kanban: визуализация потока, WIP-лимиты, cycle time;
- SAFe/Lean: координация масштабных программ.

### DevOps

- CI/CD pipeline;
- Infrastructure as Code;
- observability, incident response, postmortem-практики.

### Гибридные модели

- Water-Scrum-Fall для enterprise-проектов;
- stage-gate + iterative delivery;
- обязательная синхронизация governance и backlog.

## Пример операционного цикла спринта

1. Refinement с проверкой Definition of Ready.
1. Sprint Planning с учетом capacity и рисков.
1. Daily flow + управление блокерами.
1. Sprint Review с проверкой бизнес-ценности.
1. Retrospective с action items в backlog улучшений.

## Качество, документация и риски

Минимальный стандарт:

- тестируемые AC на уровне требований;
- контроль качества артефактов перед переходом между фазами;
- decision log по ключевым процессным решениям;
- реестр рисков и регулярный пересмотр;
- актуальная документация на каждом релизе.

## Первоисточники

- Scrum Guide: <https://scrumguides.org/>
- Kanban Guide: <https://kanbanguides.org/>
- SAFe Framework: <https://scaledagileframework.com/>
- DORA/DevOps research: <https://dora.dev/>
- ISO/IEC/IEEE 12207: <https://www.iso.org/standard/63712.html>

## Как работать с разделом

1. Начните с [этапов жизненного цикла](product-lifecycle/stages.md).
1. Выберите [режим управления потоком работ](agile-processes.md).
1. Настройте [технический контур поставки](product-lifecycle/devops-basics.md).
1. Зафиксируйте [правила качества, документации и рисков](quality-documentation-risks.md).

## Переход к подразделам

- [Жизненный цикл программного продукта](product-lifecycle/index.md)
- [Agile-процессы и практики команды](agile-processes.md)
- [Гибридные модели поставки](hybrid-models.md)
- [Качество, документация и риски](quality-documentation-risks.md)
- [Сопровождение функциональности](feature-support/index.md)
- [Основы программирования](programming-basics/index.md)
- [Тестирование](testing/index.md)

## Контрольные вопросы

- Какие артефакты обязательны на каждой фазе SDLC в вашем контуре?
- Где в процессе подтверждается бизнес-ценность и качество?
- Как интегрированы DevOps-практики в текущий delivery-поток?
- Какой гибридный подход лучше соответствует вашим ограничениям?
- Какие метрики процесса вы используете для улучшений?
