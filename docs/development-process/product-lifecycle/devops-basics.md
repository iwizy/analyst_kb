# Основы DevOps

DevOps - совместная модель работы разработки и эксплуатации, цель которой: быстрее и безопаснее поставлять изменения.

## Ключевые практики

- автоматизация build/test/deploy;
- инфраструктура как код (IaC);
- observability: логи, метрики, трейсы;
- incident response и postmortem-культура;
- shift-left по качеству и безопасности.

## IaC в контуре DevOps

| Практика | Что дает |
| --- | --- |
| Terraform/CloudFormation | воспроизводимая инфраструктура |
| GitOps | контроль изменений через pull request |
| Policy as Code | контроль соответствия стандартам |

## Операционные метрики

- deployment frequency;
- lead time for changes;
- change failure rate;
- MTTR.

## Типичные ошибки

- считать DevOps отдельной ролью вместо командной ответственности;
- автоматизировать деплой без quality gates;
- игнорировать observability на раннем этапе.
