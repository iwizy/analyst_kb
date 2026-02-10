# Распределенные реестры

Распределенный реестр (DLT) применяют, когда требуется неизменяемый журнал операций между несколькими сторонами без единого доверенного центра.

## Уровни сложности

### Базовый

- понимать сущности: блок, транзакция, узел, консенсус;
- различать public и permissioned сети.

### Средний

- оценивать PoW/PoS/PBFT по throughput, latency и безопасности;
- проектировать интеграцию реестра с корпоративными системами.

### Продвинутый

- строить архитектуру off-chain/on-chain с oracle и audit trail;
- управлять ключами, governance и compliance.

## Консенсусные алгоритмы

| Алгоритм | Производительность | Устойчивость/безопасность | Типовое применение |
| --- | --- | --- | --- |
| PoW | низкий throughput, высокая задержка | высокая устойчивость к Sybil, дорогой по энергии | public chains |
| PoS | выше throughput, ниже latency | зависит от модели стейкинга и governance | современные public chains |
| PBFT и варианты | высокий throughput в ограниченном числе валидаторов | хорош для permissioned сетей | enterprise/consortium |

## Permissioned vs Public

| Критерий | Permissioned | Public |
| --- | --- | --- |
| Участники | известные и управляемые | открытые |
| Throughput/latency | выше throughput, ниже latency | ниже throughput, выше latency |
| Конфиденциальность | выше, можно сегментировать данные | ограниченная конфиденциальность |
| Governance | централизованно/консорциум | децентрализованно |
| Подходит для | B2B, supply chain, госреестры | open ecosystems, DeFi |

## Интеграционные паттерны

```kroki-plantuml
@startuml
left to right direction
rectangle "ERP / Core system" as ERP
rectangle "Integration service" as INT
rectangle "Blockchain network" as BC
rectangle "Off-chain storage" as OFF
rectangle "Oracle service" as ORA

ERP --> INT : business event
INT --> BC : tx hash + minimal payload
INT --> OFF : full document
ORA --> BC : external data feed
BC --> ERP : status/confirmation
@enduml
```

Ключевая практика: хранить чувствительные и объемные данные off-chain, на цепочке — только хэш, ссылки и критичные атрибуты верификации.

## Кейсы по доменам

- Финансы: межбанковские гарантии и проверяемые settlement trail.
- E-commerce: отслеживание происхождения товара в supply chain.
- Госсектор: межведомственная проверка статуса документов с audit trail.

## Типовые ошибки

- выбор блокчейна там, где достаточно обычной БД + аудит-логов;
- запись персональных данных on-chain без стратегии удаления/анонимизации;
- отсутствие операционной модели управления ключами;
- недооценка интеграционной сложности с legacy.

## Практические рекомендации

1. Начинайте с требования к доверенной проверяемости, а не с технологии.
2. Ограничивайте on-chain данные минимально необходимым набором.
3. Документируйте governance: валидаторы, обновления, ключевые роли.
4. Проводите security review смарт-контрактов до production.

## Контрольные вопросы

1. Какую проблему доверия между сторонами решает реестр?
2. Какие данные должны храниться off-chain?
3. Какой консенсус удовлетворяет SLA по latency/throughput?
4. Кто отвечает за управление ключами и ротацию?

## Чек-лист самопроверки

- обоснован выбор permissioned/public модели;
- выбран консенсус и оценены его trade-off;
- спроектированы off-chain storage и oracle-поток;
- определены роли governance и security controls;
- проведены интеграционные и нагрузочные тесты.

## Стандарты и источники

- Hyperledger Fabric docs: <https://hyperledger-fabric.readthedocs.io/>
- Ethereum docs: <https://ethereum.org/en/developers/docs/>
- NIST blockchain overview: <https://csrc.nist.gov/publications/detail/nistir/8202/final>
