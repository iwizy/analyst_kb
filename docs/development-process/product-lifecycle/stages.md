# Этапы жизненного цикла ПО

Ниже приведен базовый SDLC-контур с артефактами, ролями и критериями завершения.

## Фазы и артефакты

| Фаза | Цель | Ключевые артефакты | Роли |
| --- | --- | --- | --- |
| Инициация | обосновать проект | vision, scope, business case, high-level roadmap | sponsor, PO, analyst |
| Анализ | уточнить требования | BRD/SRS, use cases, NFR, карта стейкхолдеров | analyst, PO, architect |
| Дизайн | выбрать решение | C4, ERD, API contracts, ADR | architect, analyst, lead dev |
| Разработка | реализовать инкремент | code, PR, unit tests, changelog | dev team |
| Тестирование | подтвердить качество | test cases, defect log, test report | QA, analyst |
| Развертывание | безопасно вывести в прод | release plan, rollback plan, runbook | DevOps, SRE, dev |
| Эксплуатация | обеспечить стабильность | dashboards, alerts, postmortem, backlog улучшений | SRE, support, analyst |

## Критерии перехода между фазами

- требования testable и согласованы;
- архитектурные риски закрыты или управляются;
- DoD и quality gates выполнены;
- операционные сценарии (мониторинг, rollback) проверены.

## Типичные ошибки

- начинать разработку без критериев приемки;
- пропускать фазу дизайн-решений для сложных интеграций;
- выпускать релиз без runbook и rollback-плана.
