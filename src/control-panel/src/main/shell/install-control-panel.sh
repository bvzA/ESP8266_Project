#!/bin/bash

curl -L https://github.com/bvzA/ESP8266_Project/releases/download/v0.4-alpha/control-panel.tar.gz | tar xzv

rm -rf /etc/systemd/system/control-panel.service
rm -rf /etc/init.d/control-panel
rm -rf /opt/control-panel

mv control-panel /opt/control-panel

mkdir -p /etc/control-panel
cp -f /opt/control-panel/application-template.properties /etc/control-panel/application-template.properties

# service control-panel start/stop/status (System V Init)
cp -f /opt/control-panel/cpanel /etc/init.d/control-panel

# systemctl start/stop/status/reload/restart control-panel.service (Systemd)
ln -s /opt/control-panel/control-panel.service /etc/systemd/system/control-panel.service

systemctl daemon-reload

echo "sudo systemctl start control-panel.service"