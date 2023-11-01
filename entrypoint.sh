#!/bin/sh -l

set -e

APP_OPTS=
APP_OPTS="$APP_OPTS -Dspring.profiles.active=prod"

java $APP_OPTS -jar /hubble-scanner.jar -l="${INPUT_SOURCELANGUAGE}" -r="$INPUT_ROOTDIR" -u="$INPUT_SERVERURL"
