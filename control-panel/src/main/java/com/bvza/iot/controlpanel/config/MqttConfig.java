package com.bvza.iot.controlpanel.config;

import java.util.UUID;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.persist.MqttDefaultFilePersistence;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class MqttConfig {

    @Value("${broker.url}")
    private String brokerUrl;


    @Bean(name = "publisher")
    public MqttClient publisher() throws MqttException {
        String pubId = UUID.randomUUID().toString();

        var client = new MqttClient(brokerUrl, pubId, new MqttDefaultFilePersistence("./client-persistence"));
        MqttConnectOptions options = new MqttConnectOptions();
        options.setAutomaticReconnect(true);
        options.setCleanSession(true);
        options.setConnectionTimeout(10);

        client.connect(options);

        return client;
    }

    @Bean(name = "subscriber")
    public MqttClient subscriber() throws MqttException {
        String pubId = UUID.randomUUID().toString();

        var client = new MqttClient(brokerUrl, pubId, new MqttDefaultFilePersistence("./client-persistence"));
        MqttConnectOptions options = new MqttConnectOptions();
        options.setAutomaticReconnect(true);
        options.setCleanSession(true);
        options.setConnectionTimeout(10);

        client.connect(options);

        client.subscribe("switch/#", (topic, msg) -> {
            byte[] payload = msg.getPayload();
            log.info("[I82] Message received: topic={}, payload={}", topic, new String(payload));
        });

        return client;
    }
}