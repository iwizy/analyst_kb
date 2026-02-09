# RabbitQM

RabbitMQ — это популярный брокер сообщений с открытым исходным кодом, использующий протокол AMQP (Advanced Message Queuing Protocol). Он позволяет приложениям обмениваться сообщениями асинхронно, что помогает уменьшить связность между компонентами системы, улучшить масштабируемость и повысить отказоустойчивость.

## Основные концепции RabbitMQ

- Producer (Производитель) — это приложение, которое отправляет сообщения в очередь.
- Queue (Очередь) — структура данных, которая хранит сообщения. Очередь гарантирует, что сообщение будет доставлено потребителю.
- Consumer (Потребитель) — это приложение, которое получает сообщения из очереди.
- direct — сообщения отправляются в очередь, основанную на точном совпадении маршрута.
- fanout — все сообщения направляются во все очереди, связанные с обменником.
- topic — маршрутизирует сообщения в зависимости от шаблона маршрута.
- headers — использует заголовки для маршрутизации сообщений.

## Архитектура RabbitMQ

- Producer посылает сообщение в Exchange.
- Exchange решает, куда отправить сообщение, и направляет его в одну или несколько Queues.
- Consumer читает сообщения из очереди.

## Пример использования RabbitMQ в Java

Добавление зависимостей

Для работы с RabbitMQ в Java необходимо подключить библиотеку amqp-client. Если вы используете Maven, добавьте следующую зависимость в файл pom.xml:

```text
<dependency> <groupId>com.rabbitmq</groupId> <artifactId>amqp-client</artifactId> <version>5.10.0</version> </dependency>
```

Создание производителя (Producer)

В следующем примере создается производитель, который отправляет простое сообщение в очередь.

```text
import com.rabbitmq.client.*; public class Producer { private final static String QUEUE_NAME = "hello"; public static void main(String[] argv) throws Exception { // Устанавливаем соединение и канал ConnectionFactory factory = new ConnectionFactory(); factory.setHost("localhost"); // Адрес RabbitMQ-сервера try (Connection connection = factory.newConnection(); Channel channel = connection.createChannel()) { // Создаем очередь (если она не существует) channel.queueDeclare(QUEUE_NAME, false, false, false, null); String message = "Hello World!"; // Отправляем сообщение в очередь channel.basicPublish("", QUEUE_NAME, null, message.getBytes()); System.out.println(" [x] Sent '" + message + "'"); } } }
```

В этом примере создается подключение к RabbitMQ-серверу, создается очередь с именем hello, и отправляется сообщение "Hello World!" в эту очередь.

Создание потребителя (Consumer)

Потребитель получает сообщение из очереди и выводит его на экран:

```text
import com.rabbitmq.client.*; public class Consumer { private final static String QUEUE_NAME = "hello"; public static void main(String[] argv) throws Exception { // Устанавливаем соединение и канал ConnectionFactory factory = new ConnectionFactory(); factory.setHost("localhost"); // Адрес RabbitMQ-сервера try (Connection connection = factory.newConnection(); Channel channel = connection.createChannel()) { // Создаем очередь (если она не существует) channel.queueDeclare(QUEUE_NAME, false, false, false, null); System.out.println(" [*] Waiting for messages. To exit press Ctrl+C"); // Создаем слушателя сообщений DeliverCallback deliverCallback = (consumerTag, delivery) -> { String message = new String(delivery.getBody(), "UTF-8"); System.out.println(" [x] Received '" + message + "'"); }; // Подключаемся к очереди и начинаем получать сообщения channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> { }); } } }
```

Этот код создает подключение к RabbitMQ, слушает очередь hello и, когда сообщение приходит, выводит его на экран.

## Механизм подтверждения (Acknowledgement)

RabbitMQ поддерживает механизмы подтверждения сообщений, чтобы убедиться, что сообщения были успешно доставлены и обработаны.

В Java можно включить подтверждения с помощью параметра autoAck при вызове метода basicConsume. Установка значения true означает, что сообщение считается подтвержденным сразу после его получения. Если установить false, то приложение должно явно подтверждать получение сообщения через метод basicAck.

## Пример с подтверждением

```text
channel.basicConsume(QUEUE_NAME, false, deliverCallback, consumerTag -> { }); ... // В callback методе после обработки сообщения channel.basicAck(delivery.getEnvelope().getDeliveryTag(), false);
```

## Типы обменников (Exchanges)

- direct — прямое сопоставление между обменником и очередью.
- fanout — рассылка сообщений во все очереди.
- topic — маршрутизация сообщений в зависимости от шаблонов.
- headers — маршрутизация сообщений по заголовкам.

## Пример с типом обменника fanout

```text
import com.rabbitmq.client.*; public class FanoutExchangeProducer { private final static String EXCHANGE_NAME = "logs"; public static void main(String[] argv) throws Exception { ConnectionFactory factory = new ConnectionFactory(); factory.setHost("localhost"); try (Connection connection = factory.newConnection(); Channel channel = connection.createChannel()) { // Создаем обменник типа fanout channel.exchangeDeclare(EXCHANGE_NAME, BuiltinExchangeType.FANOUT); String message = "Hello, fanout exchange!"; // Отправляем сообщение в обменник channel.basicPublish(EXCHANGE_NAME, "", null, message.getBytes()); System.out.println(" [x] Sent '" + message + "'"); } } }
```

В этом примере мы создаем обменник типа fanout, и сообщение отправляется в этот обменник, который затем рассылет его во все очереди, связанные с ним.

## Заключение

RabbitMQ — это мощный инструмент для реализации асинхронной передачи сообщений в распределенных системах. Используя простые API, мы можем отправлять и получать сообщения, обрабатывать их в разных частях приложения и легко масштабировать систему.
