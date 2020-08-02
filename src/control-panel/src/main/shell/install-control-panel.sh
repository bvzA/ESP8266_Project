#!/bin/bash

curl -L https://github.com/bvzA/ESP8266_Project/releases/download/v0.3-alpha/control-panel.tar.gz | tar xzv
mv control-panel /opt/control-panel

mkdir -p /etc/control-panel
cp /opt/control-panel/application-template.properties /etc/control-panel/application.properties

# service control-panel start/stop/status 
ln -s /opt/control-panel/cpanel /etc/init.d/control-panel

# systemctl start/stop/status control-panel.service
ln -s /opt/control-panel/control-panel.service /etc/systemd/system/control-panel.service
