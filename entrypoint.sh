#!/bin/sh -l

set -e

# Initialize JVM options and application arguments separately
JVM_OPTS="-Dspring.profiles.active=prod"
APP_ARGS=""

# Map GitHub environment variables to SCM_* variables
export SCM_REPOSITORY_FULL_NAME="$GITHUB_REPOSITORY"
export SCM_REPOSITORY_OWNER="$GITHUB_REPOSITORY_OWNER"
export SCM_REF_TYPE="$GITHUB_REF_TYPE"
export SCM_COMMIT_SHA="$GITHUB_SHA"

# Set SCM_REF_NAME based on event type
if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    export SCM_REF_NAME="$GITHUB_HEAD_REF"
elif [ "$GITHUB_EVENT_NAME" = "push" ]; then
    export SCM_REF_NAME="$GITHUB_REF_NAME"
fi

# Handle GitHub Action inputs
if [ "$INPUT_FAILONERROR" = "true" ]; then
    APP_ARGS="$APP_ARGS -f"
fi

# Process each input argument and add to APP_ARGS
if [ -n "$INPUT_PRREVIEW" ]; then
    APP_ARGS="$APP_ARGS --pr-review=$INPUT_PRREVIEW"
fi

if [ -n "$INPUT_PRWALKTHROUGH" ]; then
    APP_ARGS="$APP_ARGS --pr-walkthrough=$INPUT_PRWALKTHROUGH"
fi

if [ -n "$INPUT_STATICANALYSIS" ]; then
    APP_ARGS="$APP_ARGS --static-analysis=$INPUT_STATICANALYSIS"
fi

if [ -n "$INPUT_TIMEOUT" ]; then
    APP_ARGS="$APP_ARGS --timeout=$INPUT_TIMEOUT"
fi

if [ -n "$INPUT_SERVERURL" ]; then
    APP_ARGS="$APP_ARGS --serverUrl=$INPUT_SERVERURL"
fi

# Append remaining application arguments
APP_ARGS="$APP_ARGS -v=GitHub -t=${INPUT_TOKEN}"

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS"

# Execute the command
eval "$CMD"
