# XML/XSD

XML остается актуальным в B2B и enterprise-контуре, где важны формальные схемы, namespace и строгая валидация.

## Когда выбирать XML/XSD

- интеграции с legacy-системами и SOAP;
- сложные иерархические документы;
- формальные отраслевые стандарты и контракты.

## Пример XML

```xml
<Order xmlns="http://example.com/order">
  <OrderId>ORD-100245</OrderId>
  <Status>paid</Status>
  <Amount currency="RUB">4950.00</Amount>
</Order>
```

## Пример XSD-фрагмента

```xml
<xs:element name="Order">
  <xs:complexType>
    <xs:sequence>
      <xs:element name="OrderId" type="xs:string"/>
      <xs:element name="Status" type="xs:string"/>
      <xs:element name="Amount" type="xs:decimal"/>
    </xs:sequence>
  </xs:complexType>
</xs:element>
```

## Плюсы

- строгая валидация структуры и типов;
- развитые enterprise-инструменты;
- поддержка namespace и расширений.

## Минусы

- более "тяжелый" payload;
- сложнее читать и поддерживать;
- выше порог входа для разработки.

## Практические рекомендации

- versioning схем XSD вести явно;
- не изменять namespace без migration plan;
- валидировать XML до бизнес-логики.
