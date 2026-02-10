# SOAP

> Глоссарий терминов и сокращений: [Открыть](../../../glossary.md)


SOAP остается актуальным в regulated и legacy-интеграциях, где важны WS-* стандарты, строгие схемы и контрактный подход.

## Уровни сложности

### Базовый уровень

- понимать структуру SOAP Envelope/Body/Fault;
- читать WSDL и XSD;
- реализовывать базовые операции request/response.

### Средний уровень

- применять WS-Security и WS-Addressing;
- проектировать надежную доставку и idempotent операции;
- тестировать SOAP-контракты через SoapUI/CXF.

### Продвинутый уровень

- интегрировать SOAP с modern API gateway/microservices;
- управлять версионированием WSDL и backward compatibility;
- реализовывать security/compliance требования enterprise уровня.

## Основные элементы

| Элемент | Назначение |
| --- | --- |
| WSDL | описание сервиса, операций и типов |
| XSD | строгие схемы данных |
| SOAP Envelope | транспортная оболочка сообщения |
| SOAP Fault | стандартизированная ошибка |
| WS-Security | подпись, шифрование, токены |

## Пример SOAP-запроса

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ord="http://example.com/orders">
  <soapenv:Header/>
  <soapenv:Body>
    <ord:GetOrderRequest>
      <ord:OrderId>ord-1001</ord:OrderId>
    </ord:GetOrderRequest>
  </soapenv:Body>
</soapenv:Envelope>
```

## Пример SOAP Fault

```xml
<soap:Fault>
  <faultcode>soap:Client</faultcode>
  <faultstring>Invalid OrderId</faultstring>
</soap:Fault>
```

## WS-* расширения

- `WS-Security`: подпись и шифрование сообщений;
- `WS-Addressing`: маршрутизация и адресация;
- `WS-ReliableMessaging`: надежная доставка;
- `WS-Policy`: декларативные требования к взаимодействию.

## Когда выбирать SOAP

- интеграция с legacy enterprise или государственными системами;
- контур с жесткими требованиями к формальным контрактам и аудиту;
- обязательность WS-Security/WS-RM стандартов.

## Типичные ошибки

- попытка использовать SOAP там, где достаточно REST/gRPC;
- отсутствие стратегии версии WSDL;
- игнорирование производительности и размера XML;
- недостаточный контроль WS-Security конфигураций.
## Стандарты и источники

- SOAP 1.2: <https://www.w3.org/TR/soap12-part1/>
- WSDL: <https://www.w3.org/TR/wsdl>
- WS-Security: <https://docs.oasis-open.org/wss-m/wss/v1.1.1/wss-SOAPMessageSecurity-v1.1.1.html>
