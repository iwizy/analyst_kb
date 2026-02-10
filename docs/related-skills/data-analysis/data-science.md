# Data Science

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Data Science дополняет аналитическую практику, когда нужно не только объяснить прошлое, но и прогнозировать поведение системы.

## Уровни сложности

### Базовый уровень

- понимать DS-цикл: постановка задачи -> данные -> модель -> внедрение;
- различать бизнес-метрику и метрику модели;
- уметь формулировать baseline.

### Средний уровень

- участвовать в feature definition и quality checks;
- интерпретировать результаты модели для бизнеса;
- задавать критерии A/B-проверки ML-фич.

### Продвинутый уровень

- участвовать в MLOps-процессах (monitoring, retraining);
- формулировать требования explainability/fairness;
- согласовывать риск-профиль модели с бизнесом.

## Где Data Science полезен аналитику

| Сценарий | Роль аналитика |
| --- | --- |
| Churn prediction | уточнить цель, сегменты и экономику retention |
| Demand forecasting | определить плановую точность и horizon |
| Fraud detection | согласовать trade-off precision/recall |

## DS-цикл (рабочая схема)

1. Problem framing и критерии успеха.
2. Data understanding и качество данных.
3. Baseline и модель.
4. Валидация и ограничение рисков.
5. Внедрение и мониторинг drift.

## Типичные ошибки

- цель "построить модель" вместо решения бизнес-проблемы;
- отсутствие baseline;
- игнорирование качества и смещений данных;
- отсутствие плана сопровождения модели.

## Кросс-ссылки

- [Основы машинного обучения](../ml-basics.md)
- [Статистика и A/B-тесты](statistics-and-ab-tests.md)
- [Data-driven решения](../../common-competencies/data-driven-decisions.md)## Источники

- CRISP-DM.
- Data Science for Business (Provost, Fawcett).
- Google ML resources: <https://developers.google.com/machine-learning>
