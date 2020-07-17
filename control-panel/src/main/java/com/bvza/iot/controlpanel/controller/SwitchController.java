package com.bvza.iot.controlpanel.controller;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/switch")
public class SwitchController {

    @Autowired
    @Qualifier("publisher")
    private MqttClient publisher;

    @GetMapping("/{room}/{name}/{action}")
    public void triggerSwitch(@PathVariable("room") String room, @PathVariable("name") String name,
            @PathVariable("action") String action) throws MqttPersistenceException, MqttException {
        MqttMessage message = new MqttMessage();

        message.setQos(1);
        message.setPayload(action.getBytes());

        publisher.publish("switch/"+room+"/"+name, message);
    }
}