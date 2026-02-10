# Peer-to-peer

P2P-архитектура строится на равноправных узлах без постоянного центра. Подходит для децентрализованных и устойчивых к single-point-of-failure систем.

## Уровни сложности

### Базовый уровень

- понимать peer discovery и overlay network;
- различать централизованный и децентрализованный control plane;
- оценивать базовые риски консистентности.

### Средний уровень

- выбирать модель репликации и маршрутизации;
- работать с DHT и peer protocols;
- учитывать NAT traversal и безопасность.

### Продвинутый уровень

- проектировать консенсус и anti-entropy механизмы;
- балансировать доступность и согласованность;
- управлять устойчивостью сети при churn.

## Преимущества

- нет единой точки отказа;
- горизонтальный рост узлов;
- устойчивость к локальным сбоям.

## Недостатки

- сложный security model;
- непростая диагностика и observability;
- сложности с глобальной консистентностью.

## Примеры применения

- BitTorrent-like content distribution;
- blockchain сети;
- edge-distributed sharing.

## Технические проблемы

| Проблема | Комментарий |
| --- | --- |
| NAT traversal | нужны STUN/TURN/relay стратегии |
| DHT routing | выбор схемы Kademlia/Chord |
| Consensus | PoW/PoS/PBFT/Raft-like подходы в частных сетях |
| Security | identity, anti-sybil, key management |

## Антипаттерны

- проектирование P2P без threat model;
- отказ от протокольной версии и backward compatibility;
- недооценка churn и partitioning сети.

## Практические рекомендации

1. Формализуйте protocol contracts и версионирование.
2. Добавьте peer health-checks и reputation logic.
3. Спроектируйте fallback/relay path для NAT.
4. Для критичных данных определите модель консенсуса.
## Стандарты и источники

- Kademlia DHT paper.
- BitTorrent protocol docs.
- Blockchain architecture references.
