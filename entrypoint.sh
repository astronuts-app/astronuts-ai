#!/bin/sh -l

set -e

APP_OPTS=
APP_OPTS="$APP_OPTS -Dspring.profiles.active=prod"

java $APP_OPTS -jar /cq-scanner-app.jar -l="${INPUT_SOURCELANGUAGE}" -t="$INPUT_AUTHTOKEN" -k="${INPUT_PROJECTKEY}"
