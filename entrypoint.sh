#!/bin/sh -l

set -e

# Initialize JVM options and application arguments separately
JVM_OPTS="-Dspring.profiles.active=prod"
APP_ARGS=""

# Map GitHub environment variables to SCM_* variables
export SCM_REPOSITORY_FULL_NAME="$GITHUB_REPOSITORY"
export SCM_REPOSITORY_OWNER="$GITHUB_REPOSITORY_OWNER"
export SCM_REF_NAME="$GITHUB_REF_NAME"
export SCM_REF_TYPE="$GITHUB_REF_TYPE"
export SCM_COMMIT_SHA="$GITHUB_SHA"

echo "SCM_REPOSITORY_FULL_NAME: $SCM_REPOSITORY_FULL_NAME"
echo "SCM_REPOSITORY_OWNER: $SCM_REPOSITORY_OWNER"
echo "SCM_REF_NAME: $SCM_REF_NAME"
echo "SCM_REF_TYPE: $SCM_REF_TYPE"
echo "SCM_COMMIT_SHA: $SCM_COMMIT_SHA"

printenv

if [ "$INPUT_FAILONERROR" = "true" ]; then
    APP_ARGS="$APP_ARGS -f"
fi

# Append remaining application arguments
APP_ARGS="$APP_ARGS -v=GitHub -l=${INPUT_SOURCELANGUAGE} -r=${INPUT_ROOTDIR} -u=${INPUT_SERVERURL} -m=${INPUT_BUILDSYSTEM}"

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS"

# Execute the command
eval "$CMD"
