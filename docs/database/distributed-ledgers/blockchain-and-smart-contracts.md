# Blockchain и смарт-контракты

> Глоссарий терминов и сокращений: [Открыть](../../glossary.md)


Смарт-контракты автоматизируют исполнение бизнес-правил в распределенном реестре. Ключевой риск — неизменяемость и цена ошибки в коде.

## Уровни сложности

### Базовый

- понимать lifecycle контракта: deploy -> invoke -> state change;
- различать on-chain state и off-chain данные.

### Средний

- писать безопасные контракты и тесты;
- учитывать gas/cost и ограничения платформы.

### Продвинутый

- проектировать upgradeability и governance;
- внедрять формальную/полуформальную верификацию.

## Пример Solidity (упрощенный)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public buyer;
    address public seller;
    bool public delivered;

    constructor(address _seller) {
        buyer = msg.sender;
        seller = _seller;
    }

    function markDelivered() external {
        require(msg.sender == buyer, "only buyer");
        delivered = true;
    }
}
```

## Пример Hyperledger Fabric (идея chaincode)

```text
function CreateAsset(ctx, assetId, owner, value)
  - validate input
  - check uniqueness
  - putState(assetId, payload)
```

## Типовые уязвимости

| Уязвимость | Сценарий | Как снижать риск |
| --- | --- | --- |
| Reentrancy | повторный вход до завершения изменения состояния | checks-effects-interactions, reentrancy guards |
| Overflow/Underflow | некорректная арифметика | безопасные версии компилятора, тесты границ |
| Access control flaw | критичные функции доступны не тем ролям | role-based modifiers, least privilege |
| Oracle manipulation | внешние данные подменены/задержаны | trusted oracle, multi-source verification |

## Интеграция с корпоративным контуром

```kroki-plantuml
@startuml
left to right direction
rectangle "Core system" as CORE
rectangle "Smart contract" as SC
rectangle "Oracle" as ORA
rectangle "Off-chain DB" as OFF

CORE --> SC : invoke transaction
SC --> OFF : store hash/reference
ORA --> SC : external data
SC --> CORE : event/receipt
@enduml
```

## Практические рекомендации

1. Минимизируйте бизнес-логику в контракте, сложную логику оставляйте off-chain.
2. Делайте threat modeling и security audit до релиза.
3. Используйте testnet/staging и сценарии rollback на уровне интеграции.
4. Для критичных контрактов добавляйте pause/emergency controls.

## Типовые ошибки

- хранение чувствительных данных в открытой цепочке;
- отсутствие ограничений доступа к административным функциям;
- отсутствие тестов на граничные условия и race сценарии;
- отсутствие версии и процесса обновления контракта.
## Стандарты и источники

- Solidity docs: <https://docs.soliditylang.org/>
- OpenZeppelin contracts: <https://docs.openzeppelin.com/contracts>
- Hyperledger Fabric docs: <https://hyperledger-fabric.readthedocs.io/>
- OWASP Smart Contract Top 10: <https://owasp.org/www-project-smart-contract-top-10/>
