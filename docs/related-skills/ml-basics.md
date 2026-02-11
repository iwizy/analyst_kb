# Основы машинного обучения

ML для аналитика это способ формализовать задачу, оценить данные и определить критерии успеха модели до реализации.

## Уровни сложности

### Базовый уровень

- понимать supervised и unsupervised learning;
- различать classification, regression, clustering;
- знать train/validation/test split.

### Средний уровень

- выбирать метрику модели под бизнес-задачу;
- различать overfitting/underfitting;
- участвовать в подготовке признаков и требований к данным.

### Продвинутый уровень

- учитывать fairness, explainability и privacy;
- участвовать в ML governance и мониторинге drift;
- формулировать требования к MLOps-контуру.

## Базовые понятия

| Понятие | Что означает |
| --- | --- |
| Supervised | обучение по размеченным данным |
| Unsupervised | поиск структуры без разметки |
| Precision/Recall/F1 | качество классификации |
| ROC AUC | способность модели разделять классы |
| Cross-validation | устойчивость качества на подвыборках |

## Роль аналитика в ML-проекте

1. Сформулировать бизнес-проблему и критерий успеха.
2. Определить ограничения: риск ошибки, комплаенс, объяснимость.
3. Проверить качество и доступность данных.
4. Зафиксировать метрики модели и бизнес-метрики.
5. Участвовать в post-release мониторинге.

## Типовые ML-сценарии

| Сценарий | Пример |
| --- | --- |
| Рекомендации | personalized offers в e-commerce |
| Fraud detection | выявление аномальных транзакций |
| Churn prediction | прогноз оттока и retention-кампании |

## Этические и регуляторные риски

- bias по сегментам пользователей;
- непрозрачные решения модели;
- утечка или некорректная обработка [PII](../glossary.md#abbr-063);
- дрейф данных после релиза.

## Инструменты

- Jupyter, pandas, scikit-learn;
- TensorFlow/PyTorch для сложных моделей;
- AutoML для быстрого baseline.

## Кросс-ссылки

- [Анализ данных](data-analysis/index.md)
- [DWH и Data Lake](../database/dwh-and-data-lake.md)
- [Требования к качеству](../requirements/quality.md)

## Источники

- CRISP-DM overview: <https://www.datascience-pm.com/crisp-dm-2/>
- Coursera ML (Andrew Ng): <https://www.coursera.org/learn/machine-learning>
- Kaggle Learn: <https://www.kaggle.com/learn>
