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

# Set SCM_REF_NAME based on GITHUB_EVENT_NAME
if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    export SCM_REF_NAME="$GITHUB_HEAD_REF"
elif [ "$GITHUB_EVENT_NAME" = "push" ]; then
    export SCM_REF_NAME="$GITHUB_REF_NAME"
fi

# Handle GitHub Action inputs
if [ "$INPUT_FAILONERROR" = "true" ]; then
    APP_ARGS="$APP_ARGS -f"
fi

# Process each input argument and add to APP_ARGS if not empty
if [ -n "$INPUT_PRREVIEW" ]; then
    APP_ARGS="$APP_ARGS --prReview=$INPUT_PRREVIEW"
fi

if [ -n "$INPUT_PRWALKTHROUGH" ]; then
    APP_ARGS="$APP_ARGS --prWalkthrough=$INPUT_PRWALKTHROUGH"
fi

if [ -n "$INPUT_STATICANALYSIS" ]; then
    APP_ARGS="$APP_ARGS --staticAnalysis=$INPUT_STATICANALYSIS"
fi

if [ -n "$INPUT_TIMEOUT" ]; then
    APP_ARGS="$APP_ARGS --timeout=$INPUT_TIMEOUT"
fi

# Append remaining application arguments only if they are not empty
if [ -n "$INPUT_TOKEN" ]; then
    APP_ARGS="$APP_ARGS -t=$INPUT_TOKEN"
fi

if [ -n "$INPUT_TIMEOUT" ]; then
    APP_ARGS="$APP_ARGS -z=$INPUT_TIMEOUT"
fi

if [ -n "$INPUT_SERVERURL" ]; then
    APP_ARGS="$APP_ARGS -u=$INPUT_SERVERURL"
fi

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS -v=GitHub"

# Execute the command
eval "$CMD"