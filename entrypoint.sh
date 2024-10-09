#!/bin/sh -l

set -e

# Initialize JVM options and application arguments separately
JVM_OPTS="-Dspring.profiles.active=prod"
APP_ARGS=""

# Map GitHub environment variables to SCM_* variables
export SCM_REPOSITORY_FULL_NAME="$GITHUB_REPOSITORY"
export SCM_REPOSITORY_OWNER="$GITHUB_REPOSITORY_OWNER"
export SCM_REF_TYPE="$GITHUB_REF_TYPE"

# Set SCM_REF_NAME and get last commit SHA for pull request events
if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    export SCM_REF_NAME="$GITHUB_HEAD_REF"
    # Fetch the latest commit SHA for the pull request branch
    export SCM_COMMIT_SHA=$(git rev-parse origin/"$GITHUB_HEAD_REF")
elif [ "$GITHUB_EVENT_NAME" = "push" ]; then
    export SCM_REF_NAME="$GITHUB_REF_NAME"
    export SCM_COMMIT_SHA="$GITHUB_SHA"  # Use the default SHA for push events
else
    export SCM_COMMIT_SHA="$GITHUB_SHA"  # Default fallback
fi

if [ "$INPUT_FAILONERROR" = "true" ]; then
    APP_ARGS="$APP_ARGS -f"
fi

# Append remaining application arguments
APP_ARGS="$APP_ARGS -v=GitHub -t=${INPUT_TOKEN} -z=${INPUT_TIMEOUT} -u=${INPUT_SERVERURL}"

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS"

# Execute the command
eval "$CMD"