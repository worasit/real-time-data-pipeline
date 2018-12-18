package com.nongped.poc.schemaregistry;

import com.nongped.poc.avro.Payment;
import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import org.apache.kafka.clients.producer.*;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Properties;

public class ProducerExample {

    private static final String TOPIC = "transactions";

    public static void main(String[] args) {
        final Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        props.put(ProducerConfig.ACKS_CONFIG, "all");
        props.put(ProducerConfig.RETRIES_CONFIG, 0);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
        props.put(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://localhost:8081");
        props.put(AbstractKafkaAvroSerDeConfig.AUTO_REGISTER_SCHEMAS, false);

        try (KafkaProducer<String, Payment> producer = new KafkaProducer<>(props)) {
            for (int i = 0; i < 10; i++) {
                final String orderId = Integer.toString(i);
                final Payment payment = new Payment();
                payment.setId(orderId);
                payment.setAmount(1000D);
                payment.setRegion("USA");
                final ProducerRecord<String, Payment> record = new ProducerRecord<>(
                        TOPIC,
                        payment.getId().toString(),
                        payment
                );

                producer.send(record, (recordMetadata, e) -> {
                    if (e == null) {
                        System.out.println(
                                "topic: " + recordMetadata.topic() + "\n" +
                                        "partition: " + recordMetadata.partition() + "\n" +
                                        "offset: " + recordMetadata.offset() + "\n"
                        );
                    } else {
                        e.printStackTrace();
                    }
                });
            }
            System.out.printf("Successfully produced 10 messages to a topic called %s%n", TOPIC);
        }
    }
}

