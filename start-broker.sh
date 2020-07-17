#!/bin/bash

command -v docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; }

docker run -it -p 1883:1883 -p 9001:9001 eclipse-mosquitto