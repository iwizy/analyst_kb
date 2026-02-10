# GoF-паттерны

GoF-паттерны помогают проектировать расширяемые и тестируемые компоненты. Ниже приведены паттерны, которые чаще всего встречаются в прикладной архитектуре.

## Уровни сложности

### Базовый уровень

- понимать назначение каждого паттерна;
- распознавать паттерн в существующем коде;
- выбирать паттерн под типовую проблему.

### Средний уровень

- применять паттерны в сервисном и доменном коде;
- оценивать влияние на тестируемость и связность;
- избегать избыточной абстракции.

### Продвинутый уровень

- комбинировать паттерны осознанно;
- вводить паттерны через ADR и coding standards;
- отслеживать антипаттерны применения GoF.

## Как читать раздел

Для каждого паттерна указаны:

- определение;
- UML-схема;
- мини-пример кода;
- область применения и риски.

---

## Singleton

Определение: обеспечивает единственный экземпляр класса и глобальную точку доступа.

```kroki-plantuml
@startuml
class Singleton {
  -instance: Singleton
  +getInstance(): Singleton
}
@enduml
```

```java
public final class Config {
  private static final Config INSTANCE = new Config();
  private Config() {}
  public static Config getInstance() { return INSTANCE; }
}
```

Применение: конфигурация, registry.
Риск: глобальное состояние и сложность тестирования.

## Factory (Factory Method / Abstract Factory)

Определение: отделяет создание объектов от использования.

```kroki-plantuml
@startuml
interface PaymentClient
class StripeClient
class BankClient
class PaymentFactory {
  +create(type): PaymentClient
}
PaymentClient <|.. StripeClient
PaymentClient <|.. BankClient
@enduml
```

```java
PaymentClient c = PaymentFactory.create("stripe");
```

Применение: выбор интеграционного провайдера.
Риск: избыточная абстракция для простых кейсов.

## Strategy

Определение: инкапсулирует взаимозаменяемые алгоритмы.

```kroki-plantuml
@startuml
interface PricingStrategy
class StandardPricing
class PromoPricing
class PriceService {
  -strategy: PricingStrategy
}
PricingStrategy <|.. StandardPricing
PricingStrategy <|.. PromoPricing
@enduml
```

```java
priceService.setStrategy(new PromoPricing());
```

Применение: ценообразование, маршрутизация.
Риск: чрезмерное дробление логики.

## Observer

Определение: подписчики получают уведомления об изменениях subject.

```kroki-plantuml
@startuml
interface Observer {
  +update()
}
class Subject {
  +attach()
  +notifyObservers()
}
Subject --> Observer
@enduml
```

```java
subject.attach(emailNotifier);
subject.notifyObservers();
```

Применение: события статусов, UI обновления.
Риск: неочевидная цепочка зависимостей.

## Decorator

Определение: добавляет поведение объекту без изменения его класса.

```kroki-plantuml
@startuml
interface Notifier
class BaseNotifier
class SmsDecorator
Notifier <|.. BaseNotifier
Notifier <|.. SmsDecorator
SmsDecorator --> Notifier
@enduml
```

```java
Notifier n = new SmsDecorator(new BaseNotifier());
n.send(msg);
```

Применение: добавление кросс-функций (лог, retry, audit).
Риск: сложные цепочки декораторов.

## Command

Определение: инкапсулирует запрос как объект.

```kroki-plantuml
@startuml
interface Command {
  +execute()
}
class CreateOrderCommand
class CommandBus
Command <|.. CreateOrderCommand
CommandBus --> Command
@enduml
```

```java
commandBus.dispatch(new CreateOrderCommand(orderId));
```

Применение: queue/task processing, undo/audit.
Риск: большое число мелких команд без ценности.

## Composite

Определение: строит древовидную структуру «часть-целое» с единым интерфейсом.

```kroki-plantuml
@startuml
interface Node
class Leaf
class CompositeNode
Node <|.. Leaf
Node <|.. CompositeNode
CompositeNode --> Node
@enduml
```

```java
CompositeNode menu = new CompositeNode();
menu.add(new Leaf("Item"));
```

Применение: меню, дерево политик, каталог.
Риск: сложная навигация при глубокой иерархии.

## Adapter

Определение: адаптирует несовместимый интерфейс к целевому контракту.

```kroki-plantuml
@startuml
interface PaymentPort
class LegacyBankApi
class BankAdapter
PaymentPort <|.. BankAdapter
BankAdapter --> LegacyBankApi
@enduml
```

```java
PaymentPort port = new BankAdapter(new LegacyBankApi());
```

Применение: legacy интеграции.
Риск: скрытие несовместимостей без явного контракта.

## Proxy

Определение: заместитель объекта для контроля доступа, кэша, remote вызова.

```kroki-plantuml
@startuml
interface Catalog
class RealCatalog
class CatalogProxy
Catalog <|.. RealCatalog
Catalog <|.. CatalogProxy
CatalogProxy --> RealCatalog
@enduml
```

```java
Catalog c = new CatalogProxy(realCatalog, cache);
```

Применение: lazy load, security, remote facade.
Риск: неочевидные задержки и побочные эффекты.

## Builder

Определение: пошаговая сборка сложного объекта.

```kroki-plantuml
@startuml
class OrderBuilder {
  +withItems()
  +withDiscount()
  +build()
}
@enduml
```

```java
Order o = Order.builder().withItems(items).withDiscount(d).build();
```

Применение: создание сложных DTO/aggregate.
Риск: лишний слой для простых объектов.

## Iterator

Определение: последовательный доступ к элементам коллекции без раскрытия внутренней структуры.

```kroki-plantuml
@startuml
interface Iterator
class Collection
Collection --> Iterator
@enduml
```

```java
for (Item i : collection) { process(i); }
```

Применение: унифицированный проход по коллекциям.
Риск: неэффективный обход тяжелых структур.

## Facade

Определение: единый упрощенный интерфейс к подсистеме.

```kroki-plantuml
@startuml
class CheckoutFacade
class PaymentService
class InventoryService
class DeliveryService
CheckoutFacade --> PaymentService
CheckoutFacade --> InventoryService
CheckoutFacade --> DeliveryService
@enduml
```

```java
checkoutFacade.placeOrder(cmd);
```

Применение: orchestration входной точки процесса.
Риск: превращение facade в god-class.

---

## Плюсы и минусы GoF в enterprise-проектах

| Плюсы | Минусы |
| --- | --- |
| проверенные шаблоны решений | риск over-engineering |
| повышают расширяемость | рост числа абстракций |
| упрощают общий язык команды | неверное применение ухудшает дизайн |

## Практические рекомендации

1. Вводите паттерн только под реальную повторяющуюся проблему.
2. Фиксируйте решение в ADR и code review checklist.
3. Проверяйте, что паттерн не ухудшил читаемость.
4. Сверяйтесь с [DDD](../design-approaches/oop-design/ddd.md) и [Hexagonal](hexagonal-architecture.md).

## Контрольные вопросы

1. Какой GoF-паттерн лучше всего решает текущую проблему и почему?
2. Какие паттерны вы используете "на автомате" без необходимости?
3. Где в вашем коде Facade или Singleton стал антипаттерном?
4. Какие паттерны повышают, а какие снижают testability?

## Чек-лист самопроверки

- паттерн выбран под конкретный problem statement;
- есть UML и пример применения;
- известны ограничения и риски;
- паттерн не создает лишнюю сложность;
- решение покрыто тестами.

## Стандарты и источники

- Gamma et al., *Design Patterns*.
- Fowler, *Patterns of Enterprise Application Architecture*.
- Refactoring Guru pattern catalog: <https://refactoring.guru/design-patterns>
