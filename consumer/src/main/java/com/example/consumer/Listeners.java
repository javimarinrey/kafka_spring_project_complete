
package com.example.consumer;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class Listeners {
    private static final Logger log = LoggerFactory.getLogger(Listeners.class);

    @KafkaListener(topics = "mi-topic", containerFactory = "kafkaListenerContainerFactory")
    public void listen(String message) {
        // Procesamiento idempotente recomendado
        log.info("Recibido: {}", message);
        // Aquí podrías guardar en BD, llamar a otro microservicio, etc.
    }
}
