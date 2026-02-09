# Обмен файлами

Файловая интеграция это batch-передача данных через CSV/XML/JSON/Parquet по SFTP, object storage или managed transfer.

## Когда подходит

- B2B обмен с фиксированными окнами;
- legacy-системы без API;
- большие выгрузки и пакетная обработка.

## Типовой поток

```plantuml
@startuml
participant Source
folder "SFTP / Object Storage" as Storage
participant Consumer

Source -> Storage: upload file + checksum
Consumer -> Storage: poll/download
Consumer -> Consumer: validate schema/checksum
Consumer -> Consumer: import + ack
@enduml
```

## Что нужно фиксировать в контракте

- формат файла и версия схемы;
- naming convention и директории;
- частота поставки и SLA;
- checksum/signature;
- ack/reject протокол;
- reprocessing policy.

## Достоинства

- простая интеграция между разными платформами;
- удобен для больших batch-данных;
- минимальные требования к runtime доступности сторон.

## Недостатки

- высокая латентность;
- сложнее отслеживать near-real-time состояние;
- риск ошибок формата/частичной доставки.

## Практические рекомендации

- version schema и держать backward-compatible формат;
- добавлять манифест файла и контрольную сумму;
- логировать каждую доставку и результат обработки;
- проектировать безопасный re-run без дублирования данных.

## Смежные материалы

- [Интеграционные паттерны](patterns.md)
- [Паттерны надежности](reliability-patterns.md)
