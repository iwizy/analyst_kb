# Apache Kafka

Apache Kafka — это распределённая платформа для работы с потоками данных (streaming platform), изначально разработанная в LinkedIn и позже переданная в фонд Apache. Kafka широко используется для передачи, обработки и хранения потоков событий в режиме реального времени. Она эффективна для приложений, где требуется высокая производительность, масштабируемость и устойчивость к сбоям.

## Основные компоненты Kafka

Producer (производитель): Отправляет данные (сообщения) в одну или несколько тем (topics) в Kafka.

Пример: Онлайн-магазин отправляет информацию о новых заказах в тему "orders".

Consumer (потребитель): Получает сообщения из одной или нескольких тем.

Пример: Сервис аналитики забирает заказы из темы "orders" для дальнейшего анализа.

Topic (тема): Логический канал для группировки сообщений. Темы разделяются на разделы (partitions) для масштабирования.

Пример: Тема "logs" может быть разделена на 4 партиции для параллельной обработки логов от разных серверов.

Partition (раздел): Темы разбиваются на партиции, чтобы данные можно было распределить по нескольким узлам. Каждый раздел хранится в виде лог-файла.

Пример: Логирование распределяется по разделам: логи с сервера A в раздел 1, с сервера B — в раздел 2.

Broker (брокер): Сервер Kafka, хранящий данные тем и обрабатывающий запросы от продюсеров и потребителей.

Пример: Кластер из трёх брокеров может обслуживать десятки тысяч клиентов.

ZooKeeper: Использовался для координации работы брокеров в старых версиях Kafka (до Kafka 2.8). Сейчас заменён встроенным Kafka KRaft.

Kafka Connect: Инструмент для интеграции с внешними системами, такими как базы данных, системы аналитики и облачные сервисы.

Kafka Streams: Библиотека для обработки данных в потоках прямо в приложении.

## Основные характеристики Kafka

- Высокая производительность: Kafka может обрабатывать миллионы сообщений в секунду.
- Масштабируемость: Поддерживает масштабирование как на уровне тем (с помощью партиций), так и на уровне брокеров.
- Долговечность: Сообщения хранятся на диске, что гарантирует их сохранность.
- Устойчивость к сбоям: Репликация данных обеспечивает высокую доступность.
- Гибкость: Поддержка как потоковой обработки, так и обработки "батчами" (пакетами).
## Примеры использования Apache Kafka

Логирование: Kafka часто используется для сбора логов с серверов. Например:

- Серверы отправляют логи в тему "server-logs".
- Аналитическая система или система мониторинга читает эти логи для анализа.
Потоковая аналитика: Приложение для аналитики может в реальном времени обрабатывать заказы, поступающие в тему "orders", и обновлять дашборды.

Передача сообщений: Kafka используется как брокер сообщений между микросервисами.

Пример: Микросервис A отправляет событие "создан заказ" в Kafka. Микросервис B, который отвечает за отправку уведомлений, читает эти события и отправляет email.

ETL (Extract, Transform, Load): Kafka помогает собирать данные из разных источников, обрабатывать их в режиме реального времени и сохранять в хранилище.

## Пример кода для работы с Kafka (на Java)

### Producer — отправка сообщений

```
import org.apache.kafka.clients.producer.KafkaProducer; import org.apache.kafka.clients.producer.ProducerRecord; import java.util.Properties; public class KafkaProducerExample { public static void main(String[] args) { // Настройки Kafka Producer Properties props = new Properties(); props.put("bootstrap.servers", "localhost:9092"); props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer"); props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer"); // Создание продюсера KafkaProducer<String, String> producer = new KafkaProducer<>(props); // Отправка сообщений for (int i = 0; i < 10; i++) { String key = "key-" + i; String value = "message-" + i; producer.send(new ProducerRecord<>("orders", key, value)); System.out.println("Сообщение отправлено: " + value); } producer.close(); } }
```

### Consumer — получение сообщений

```
import org.apache.kafka.clients.consumer.ConsumerRecords; import org.apache.kafka.clients.consumer.KafkaConsumer; import org.apache.kafka.clients.consumer.ConsumerRecord; import java.util.Collections; import java.util.Properties; public class KafkaConsumerExample { public static void main(String[] args) { // Настройки Kafka Consumer Properties props = new Properties(); props.put("bootstrap.servers", "localhost:9092"); props.put("group.id", "analytics-group"); props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer"); props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer"); // Создание консюмера KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props); // Подписка на тему consumer.subscribe(Collections.singletonList("orders")); // Чтение сообщений while (true) { ConsumerRecords<String, String> records = consumer.poll(1000); for (ConsumerRecord<String, String> record : records) { System.out.printf("Получено сообщение: key = %s, value = %s, offset = %d%n", record.key(), record.value(), record.offset()); } } } }
```

## Преимущества Apache Kafka

- Производительность: Высокая пропускная способность и низкие задержки.
- Надёжность: Репликация и хранение данных.
- Поддержка интеграции: Kafka Connect поддерживает множество коннекторов к сторонним системам.
- Сообщество и документация: Широкое сообщество пользователей и множество обучающих материалов.
## Заключение

Apache Kafka — мощный инструмент для работы с потоками данных. Она подходит для различных задач: от простого логирования до сложной аналитики данных в реальном времени. Благодаря своей гибкости, Kafka нашла применение в компаниях по всему миру.

> Материал адаптирован по статье `https://iwizy.github.io/integrations/types/brokers/kafka`.

