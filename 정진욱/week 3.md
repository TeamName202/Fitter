# Apache Kafka In Java
자바에서 Apache Kafka를 사용하는 법

# 필요한 라이브러리

```groovy
dependencies {
    // <https://mvnrepository.com/artifact/org.apache.kafka/kafka-clients>
    implementation 'org.apache.kafka:kafka-clients:3.5.1'
    // <https://mvnrepository.com/artifact/org.slf4j/slf4j-api>
    implementation 'org.slf4j:slf4j-api:2.0.9'
    // <https://mvnrepository.com/artifact/org.slf4j/slf4j-simple>
    implementation 'org.slf4j:slf4j-simple:2.0.9'
}
```

# 프로듀서 예제

## 예제1

```java
public class ProducerDemo {

    private static final Logger log = LoggerFactory.getLogger(ProducerDemo.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I am a Kafka Producer!");

        // create Producer Porperties
        Properties properties = new Properties();

        // connect to Localhost
        properties.setProperty("bootstrap.servers", "127.0.0.1:9092");

        // set producer properties 
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());

        // create the Producer
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        // create a Producer record
        ProducerRecord<String, String> producerRecord =  new ProducerRecord<>("demo_java", "hello World");

        // send data
        producer.send(producerRecord);

        // tell the producer to send all data and block until done --synchronous
        producer.flush();

        // flush and close the producer
        producer.close();

    }
}
```

1. 바이트로 변환할 때 사용할 Serializer를 지정
2. 데이터를 담을 토픽과 키, 값을 지정
3. 프로듀서로 지정한 토픽에 데이터를 보낸다.
4. 그리고 close로 프로듀서를 닫아준다.
  - close기능에 flush도 포함되어 굳이 작성하지 않아도 되지만 설명을 위해 달아주었다.

## 예제2

```java
public class ProducerDemoWithCallback {

    private static final Logger log = LoggerFactory.getLogger(ProducerDemoWithCallback.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I am a Kafka Producer!");

        // create Producer Porperties
        Properties properties = new Properties();

        // connect to Localhost
        properties.setProperty("bootstrap.servers", "127.0.0.1:9092");

        // set producer properties
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());

        properties.setProperty("batch.size", "400");

        // create the Producer
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        for (int j=0; j<10; j++) {

            for (int i = 0; i < 30; i++) {

                // create a Producer record
                ProducerRecord<String, String> producerRecord = new ProducerRecord<>("demo_java", "hello World " + i);

                // send data
                producer.send(producerRecord, new Callback() {
                    @Override
                    public void onCompletion(RecordMetadata metadata, Exception e) {
                        // executes every time a record successfully sent or an exception is thrown
                        if (e == null) {
                            // the record was successfully sent
                            log.info("Received new medtadata \\n" +
                                    "Topic: " + metadata.topic() + " \\n " +
                                    "Partition: " + metadata.partition() + " \\n " +
                                    "Offset: " + metadata.offset() + " \\n " +
                                    "Timestamp: " + metadata.timestamp());
                        } else {
                            log.error("Error while producing", e);
                        }
                    }
                });
            }
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }

            }

        // tell the producer to send all data and block until done --synchronous
        producer.flush();

        // flush and close the producer
        producer.close();

    }
}
```

## 예제3

```java
public class ProducerDemoWithKeys {

    private static final Logger log = LoggerFactory.getLogger(ProducerDemoWithKeys.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I am a Kafka Producer!");

        // create Producer Porperties
        Properties properties = new Properties();

        // connect to Localhost
        properties.setProperty("bootstrap.servers", "127.0.0.1:9092");

        // set producer properties
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());

        properties.setProperty("batch.size", "400");

        // create the Producer
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        for (int j = 0; j < 2; j++) {

            for (int i = 0; i < 10; i++) {

                String topic = "demo_java";

                String key = "id_" + i;
                String value = "hello world " + i;

                // create a Producer record
                ProducerRecord<String, String> producerRecord = new ProducerRecord<>(topic, key, value);

                // send data
                producer.send(producerRecord, new Callback() {
                    @Override
                    public void onCompletion(RecordMetadata metadata, Exception e) {
                        // executes every time a record successfully sent or an exception is thrown
                        if (e == null) {
                            // the record was successfully sent
                            log.info("Key: " + key + " | Partition: " + metadata.partition());
                        } else {
                            log.error("Error while producing", e);
                        }
                    }
                });
            }

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        // tell the producer to send all data and block until done --synchronous
        producer.flush();

        // flush and close the producer
        producer.close();

    }
}
```

# 컨슈머 예제

## 예제1

```java
public class ConsumerDemo {

    private static final Logger log = LoggerFactory.getLogger(ConsumerDemo.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I am a Kafka Consumer!");

        String groupId = "my-java-application";
        String topic = "demo_java";

        // create Producer Porperties
        Properties properties = new Properties();

        // connect to Localhost
        properties.setProperty("bootstrap.servers", "127.0.0.1:9092");

        // create consumer configs
        properties.setProperty("key.deserializer", StringDeserializer.class.getName());
        properties.setProperty("value.deserializer", StringDeserializer.class.getName());
        properties.setProperty("group.id", groupId);
        properties.setProperty("auto.offset.reset", "earliest");
        // earliest -> 토픽 맨 처음부터
        // latest -> 방금 보낸 새 메시지만

        // create a consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);

        // subscribe to a topic
        consumer.subscribe(Arrays.asList(topic));

        // poll for data
        while (true) {

            log.info("Polling");

            ConsumerRecords<String ,String> records = consumer.poll(Duration.ofMillis(1000));
            // Kafka로부터 데이터를 받기 위해 1초를 기다리고 받는다. (과부화 방지)

            for (ConsumerRecord<String, String> record : records){
                log.info("Key: " + record.key() + ", Value: " + record.value());
                log.info("Partition: " + record.partition() + ", Offset " + record.offset());
            }
        }
    }
}
```

## 예제2

```java
public class ConsumerDemoWithShutdown {

    private static final Logger log = LoggerFactory.getLogger(ConsumerDemoWithShutdown.class.getSimpleName());

    public static void main(String[] args) {
        log.info("I am a Kafka Consumer!");

        String groupId = "my-java-application";
        String topic = "demo_java";

        // create Producer Porperties
        Properties properties = new Properties();

        // connect to Localhost
        properties.setProperty("bootstrap.servers", "127.0.0.1:9092");

        // create consumer configs
        properties.setProperty("key.deserializer", StringDeserializer.class.getName());
        properties.setProperty("value.deserializer", StringDeserializer.class.getName());
        properties.setProperty("group.id", groupId);
        properties.setProperty("auto.offset.reset", "earliest");
        // earliest -> 토픽 맨 처음부터
        // latest -> 방금 보낸 새 메시지만

        // create a consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);

        // get a reference to the main thread
        final Thread mainThread = Thread.currentThread();

        // adding the shutdown hook
        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() { // 셧다운이 있을 때 실행될 스레드
                log.info("Detected a shutdown, let's exit by calling consumer.wakeup()...");
                consumer.wakeup(); // WakeupException 예외 발생 시키기

                // join the main thread to allow the execution of the code in the main thread
                try {
                    mainThread.join(); // 메인 스레드 들어가기
                } catch (InterruptedException e){
                    e.printStackTrace();
                }
            }
        });

        try {
            // subscribe to a topic
            consumer.subscribe(Arrays.asList(topic));

            // poll for data
            while (true) {

                ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(1000));
                // Kafka로부터 데이터를 받기 위해 1초를 기다리고 받는다. (과부화 방지)

                for (ConsumerRecord<String, String> record : records) {
                    log.info("Key: " + record.key() + ", Value: " + record.value());
                    log.info("Partition: " + record.partition() + ", Offset " + record.offset());
                }
            }
        } catch (WakeupException e) {
            log.info("Consumer is starting to shut down");
        } catch (Exception e){
            log.error("Unexpected exception in the consumer", e);
        } finally {
            consumer.close();
            log.info("The consumer is now gracefully shut down");
        }
    }
}
```

## Round Robin과 Sticky Partitioner의 차이

- Round Robin은 데이터 개수마다 전송 작업을 해야하는데 Sticky Partitioner는 batch로 묶어 한 파티션에 전송하기 때문에 더 빠르다.
- Sticky Partitioner의 기본 Batch 사이즈는 16KB인데 배치크기를 바꾸지 않고 그대로 사용하는 것이 권장된다.

## 리밸런싱

- 컨슈머가 그룹에서 나갔다가 들어올 때 컨슈머 사이에서 파티션이 이동하는 상황
- 관리자가 새 파티션을 토픽에 추가하는 경우

### 적극적 리밸런싱

- 컨슈머와 파티션 사이의 관계를 모두 멈추고 무작위로 새로 연결
- 즉, 모든 파티션을 모든 컨슈머에 재할당

### 협력적 리밸런싱 (점진적 리밸런싱)

- 파티션의 일부만 다른 컨슈머에 재할당

## 프로듀서 효율 높이기

linger.ms 설정 : ProducerConfig.LINGER_MS_CONFIG, “20”

batch.size 설정: ProducerConfig.BATCH_SIZE_CONFIG, 32 * 1024

compression.type 설정: snappy
