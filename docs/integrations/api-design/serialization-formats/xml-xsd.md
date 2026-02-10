# XML/XSD

XML/XSD по-прежнему важен в B2B и legacy-интеграциях, где нужны строгие схемы и расширенные enterprise-стандарты.

## Уровни сложности

### Базовый уровень

- понимать структуру XML-документа;
- валидировать сообщения по XSD;
- использовать namespace и версии схем.

### Средний уровень

- проектировать XSD с учетом эволюции;
- использовать XML Signature/Encryption для чувствительных данных;
- оптимизировать обработку больших XML-файлов.

### Продвинутый уровень

- внедрять WS-* стандарты в enterprise-контуре;
- строить безопасный обмен с проверкой подписи и шифрования;
- управлять версионированием и миграциями XSD в долгоживущих интеграциях.

## Пример XML

```xml
<Order xmlns="http://example.com/orders/v1">
  <OrderId>ord-1001</OrderId>
  <Amount currency="USD">120.50</Amount>
  <Status>PAID</Status>
</Order>
```

## Пример XSD-фрагмента

```xml
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
           targetNamespace="http://example.com/orders/v1"
           xmlns="http://example.com/orders/v1"
           elementFormDefault="qualified">
  <xs:element name="Order" type="OrderType"/>
  <xs:complexType name="OrderType">
    <xs:sequence>
      <xs:element name="OrderId" type="xs:string"/>
      <xs:element name="Amount" type="xs:decimal"/>
      <xs:element name="Status" type="xs:string"/>
    </xs:sequence>
  </xs:complexType>
</xs:schema>
```

## Плюсы и минусы

| Плюсы | Минусы |
| --- | --- |
| строгая валидация и типизация | объемные сообщения |
| зрелые security-стандарты (WS-Security) | сложнее реализация и сопровождение |
| подходит для регламентного B2B обмена | выше latency и CPU overhead |

## Практики эволюции схем

- новые поля добавляйте как optional;
- повышайте namespace/version при breaking-change;
- публикуйте compatibility matrix между версиями XSD;
- тестируйте producer/consumer на старых и новых схемах.

## Контрольные вопросы

1. Какой namespace/versioning policy используется?
2. Какие меры защищают XML от signature wrapping и XXE?
3. Как тестируется совместимость XSD между релизами?
4. Нужен ли streaming parser для больших документов?

## Чек-лист самопроверки

- XSD-валидация обязательна в CI и runtime;
- namespace и версии схем документированы;
- определены security-практики для XML;
- есть migration guide для schema changes;
- тесты покрывают backward compatibility.

## Стандарты и источники

- XML 1.0: <https://www.w3.org/TR/xml/>
- XML Schema 1.1: <https://www.w3.org/TR/xmlschema11-1/>
- WS-Security: <https://docs.oasis-open.org/wss-m/wss/v1.1.1/wss-SOAPMessageSecurity-v1.1.1.html>
