#!/bin/sh -l

set -e

# Initialize JVM options and application arguments separately
JVM_OPTS="-Dspring.profiles.active=prod"
APP_ARGS=""

if [ "$INPUT_FAILONERROR" = "true" ]; then
    APP_ARGS="$APP_ARGS -f"
fi

# Append remaining application arguments
APP_ARGS="$APP_ARGS -v=GitHub -l=${INPUT_SOURCELANGUAGE} -r=${INPUT_ROOTDIR} -u=${INPUT_SERVERURL} -m=${INPUT_BUILDSYSTEM}"

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS"

# Execute the command
eval "$CMD"
