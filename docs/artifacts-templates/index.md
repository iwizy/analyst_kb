# Единые шаблоны артефактов

Раздел содержит унифицированные шаблоны, которые используются в разных частях базы знаний и проектах.

## Когда использовать

- при запуске новой инициативы, чтобы не собирать артефакты с нуля;
- при выравнивании форматов между командами;
- при аудите качества требований, рисков и трассировки.

## Состав шаблонов

- [BRD (Business Requirements Document)](brd-template.md)
- [SRS (Software Requirements Specification)](srs-template.md)
- [RTM (Requirements Traceability Matrix)](rtm-template.md)
- [Risk Register](risk-register-template.md)
- [Stakeholder Map + RACI](stakeholder-map-template.md)

## Правила использования

- фиксируйте версию документа (`vX.Y.Z`) и дату обновления;
- указывайте владельца артефакта и ритм пересмотра;
- связывайте шаблоны между собой: `BRD -> SRS -> RTM -> Test`.

## Кросс-ссылки

- [Подходы к спецификации](../requirements/specification-approaches.md)
- [Трассировка требований](../requirements/management/traceability.md)
- [Управление рисками](../common-competencies/estimation-risks/risk-management.md)
- [Управление стейкхолдерами](../common-competencies/stakeholder-management.md)
