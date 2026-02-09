# SOAP

SOAP это протокол обмена XML-сообщениями с формализованным контрактом (WSDL), часто применяемый в enterprise и B2B-интеграциях.

## Когда выбирать SOAP

- требуется строгий контракт и XSD-валидация;
- есть legacy-ландшафт и существующие SOAP-сервисы;
- важны WS-* стандарты (security, addressing, reliable messaging).

## Компоненты

- Envelope;
- Header;
- Body;
- Fault.

## Пример SOAP-запроса

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetOrder xmlns="http://example.com/orders">
      <OrderId>ORD-100245</OrderId>
    </GetOrder>
  </soap:Body>
</soap:Envelope>
```

## Пример SOAP Fault

```xml
<soap:Fault>
  <faultcode>soap:Client</faultcode>
  <faultstring>Invalid OrderId</faultstring>
</soap:Fault>
```

## Достоинства

- строгая типизация и валидация;
- развитый enterprise-стек;
- формальное описание сервиса через WSDL.

## Недостатки

- более сложный и тяжелый протокол;
- выше стоимость разработки и поддержки;
- менее удобен для легковесных web/mobile клиентов.

## Практические рекомендации

- версионировать WSDL/XSD осознанно;
- фиксировать fault model;
- использовать mTLS и WS-Security при внешних интеграциях;
- покрывать контракт integration tests.

## Смежные материалы

- [XML/XSD](../../api-design/serialization-formats/xml-xsd.md)
- [Безопасность API (OAuth 2.0, JWT, mTLS)](../../api-design/security.md)
