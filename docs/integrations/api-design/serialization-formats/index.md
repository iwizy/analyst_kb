# Форматы сериализации

Формат сериализации влияет на совместимость, производительность, размер сообщений и сложность поддержки контрактов.

## Уровни сложности

### Базовый уровень

- выбирать JSON/XML для читаемости и совместимости;
- понимать роль схем (JSON Schema, XSD);
- учитывать требования интеграционного контракта.

### Средний уровень

- выбирать бинарные форматы для high-throughput;
- проектировать schema evolution;
- внедрять schema registry и compatibility rules.

### Продвинутый уровень

- балансировать latency/size/CPU в real-time системах;
- проектировать multi-format платформы ([REST](../../../glossary.md#abbr-071) + [gRPC](../../../glossary.md#abbr-036) + Kafka);
- автоматизировать проверку и миграции схем.

## Сравнение форматов

| Формат | Тип | Сильные стороны | Ограничения | Типовые сценарии |
| --- | --- | --- | --- | --- |
| JSON | текстовый | читаемость, экосистема | объемнее бинарных | public [API](../../../glossary.md#abbr-005), web/mobile |
| XML/XSD | текстовый | строгая валидация, legacy standard | многословность | enterprise B2B, [SOAP](../../../glossary.md#abbr-083) |
| YAML | текстовый | удобен для конфигураций | чувствителен к отступам | [CI/CD](../../../glossary.md#abbr-017), инфраструктурные манифесты |
| Protobuf | бинарный | компактный, быстрый, строгий контракт | нечитабелен без tools | gRPC, internal services |
| Avro | бинарный | сильная schema evolution, Kafka ecosystem | сложнее для прямого чтения | event streaming |
| Thrift | бинарный/текстовый | multi-language RPC | меньше распространение сейчас | legacy RPC |
| FlatBuffers | бинарный | zero-copy read, низкая latency | выше сложность модели | game/embedded/real-time |
| CBOR/MessagePack | бинарный | компактность для IoT | меньше стандартизированных контрактов | edge/IoT payloads |
| BSON | бинарный | нативен для MongoDB | слабее межплатформенно как стандарт | document databases |

## Практика выбора

1. Нужна максимальная совместимость и человеческая читаемость: `JSON`.
2. Нужна строгая enterprise-схема и legacy интеграции: `XML/XSD`.
3. Нужен быстрый M2M с жесткой схемой: `Protobuf`.
4. Нужна эволюция схем в event streaming: `Avro + Schema Registry`.
5. Нужен ultra-low latency на edge: `FlatBuffers/MessagePack/CBOR`.

## Рекомендации

- фиксируйте schema version внутри контракта;
- задавайте backward/forward compatibility rules;
- не смешивайте форматы в одном endpoint без явной версии;
- проводите нагрузочный тест с реальными payload.

## Переход к подразделам

- [JSON](json.md)
- [XML/XSD](xml-xsd.md)
- [YAML](yaml.md)
## Стандарты и источники

- [RFC](../../../glossary.md#abbr-072) 8259 JSON: <https://www.rfc-editor.org/rfc/rfc8259>
- XML 1.0: <https://www.w3.org/TR/xml/>
- JSON Schema: <https://json-schema.org/specification>
- Protocol Buffers: <https://protobuf.dev/>
- Apache Avro: <https://avro.apache.org/docs/current/>
