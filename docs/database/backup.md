# Бэкапирование данных
Backup — обязательная часть надежности данных. Ключевой показатель зрелости: не факт наличия бэкапа, а подтвержденная восстанавливаемость в заданный [RTO](../glossary.md#abbr-076)/[RPO](../glossary.md#abbr-074).

## Уровни сложности

### Базовый

- full/incremental backup;
- RPO/RTO и retention policy.

### Средний

- snapshot backups (LVM/EBS);
- offsite storage и проверка целостности.

### Продвинутый

- DR-план: cold/warm/hot standby;
- автоматизированные restore drills и runbook.

## Бэкап в разных СУБД

### PostgreSQL

- `pg_basebackup` для full backup;
- WAL archiving для point-in-time recovery.

### MySQL

- `mysqldump` (логический), `xtrabackup` (физический);
- binlog для PITR.

### MongoDB

- `mongodump`/`mongorestore`;
- snapshot уровне storage/volume.

## Snapshot и offsite

- LVM/EBS snapshots для быстрой консистентной копии;
- offsite backup в отдельный регион/провайдера;
- immutable backup policy для защиты от ransomware.

## DR режимы

| Режим | Характеристика | Типовой RTO |
| --- | --- | --- |
| Cold standby | резервная среда поднимается при аварии | часы |
| Warm standby | частично готовая среда, регулярная синхронизация | десятки минут |
| Hot standby | активная реплика, быстрый failover | минуты |

## Метрики backup/restore

- backup success rate;
- restore time (фактический);
- retention coverage;
- backup freshness;
- доля проверенных восстановлений.

## Шаблон runbook

1. Trigger: критерий запуска восстановления.
2. Scope: какие базы/схемы восстанавливаются.
3. Restore steps: последовательность действий.
4. Validation: контрольные запросы и сверка данных.
5. Rollback/escalation: кто и как принимает решение.
6. Postmortem: фиксация улучшений.

## Типовые ошибки

- backup есть, но restore не тестировался;
- хранение бэкапов в том же failure domain;
- отсутствие контроля retention и шифрования;
- нет runbook и ответственных ролей.

## Практические рекомендации

1. Тестируйте восстановление регулярно, не реже ежеквартально.
2. Разделяйте backup контур от production по региону/доступам.
3. Шифруйте backup и управляйте ключами отдельно.
4. Автоматизируйте отчеты по backup health.
## Стандарты и источники

- PostgreSQL backup/restore: <https://www.postgresql.org/docs/current/backup.html>
- MySQL backup methods: <https://dev.mysql.com/doc/refman/en/backup-methods.html>
- MongoDB backup docs: <https://www.mongodb.com/docs/manual/core/backups/>
- NIST SP 800-34 (contingency planning): <https://csrc.nist.gov/publications/detail/sp/800-34/rev-1/final>
