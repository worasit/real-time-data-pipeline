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
        final Properties properties = new Properties();
        properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        properties.put(ProducerConfig.ACKS_CONFIG, "all");
        properties.put(ProducerConfig.RETRIES_CONFIG, 0);
        properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, KafkaAvroSerializer.class);
        properties.put(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://localhost:8081");

        try (KafkaProducer<String, Payment> producer = new KafkaProducer<>(properties)) {
            for (int i = 0; i < 10; i++) {
                final String orderId = Integer.toString(i);
                final Payment payment = new Payment(orderId, 1000.00d);
                final ProducerRecord<String, Payment> record = new ProducerRecord<>(
                        TOPIC,
                        payment.getId().toString(),
                        payment
                );

                producer.send(record, new Callback() {
                    @Override
                    public void onCompletion(RecordMetadata recordMetadata, Exception e) {
                        if (e == null) {
                            System.out.println(
                                    "topic: " + recordMetadata.topic() + "\n" +
                                            "partition: " + recordMetadata.partition() + "\n" +
                                            "offset: " + recordMetadata.offset() + "\n"
                            );
                        } else {
                            e.printStackTrace();
                        }
                    }
                });
            }
            System.out.printf("Successfully produced 10 messages to a topic called %s%n", TOPIC);
        }
    }
}

