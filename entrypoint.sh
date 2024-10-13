#!/bin/sh -l

set -e

# Initialize JVM options and application arguments separately
JVM_OPTS="-Dspring.profiles.active=prod"
APP_ARGS=""

# Load the configuration from file if provided
if [ -n "$INPUT_CONFIGFILEPATH" ]; then
  if [ -f "$INPUT_CONFIGFILEPATH" ]; then
    echo "Loading configuration from $INPUT_CONFIGFILEPATH"

    # Read configuration file using yq or any other parser you may prefer
    CONFIG_ROOT_DIR=$(yq '.rootDir' "$INPUT_CONFIGFILEPATH")
    CONFIG_FAIL_ON_ERROR=$(yq '.failOnError' "$INPUT_CONFIGFILEPATH")
    CONFIG_LANGUAGE=$(yq '.language' "$INPUT_CONFIGFILEPATH")
    CONFIG_BUILD_SYSTEM=$(yq '.buildSystem' "$INPUT_CONFIGFILEPATH")
    CONFIG_TEST_REPORTS_ROOT=$(yq '.test-reports-root' "$INPUT_CONFIGFILEPATH")
    CONFIG_COVERAGE_LIB=$(yq '.coverage-lib' "$INPUT_CONFIGFILEPATH")
    CONFIG_COVERAGE_REPORT_PATHS=$(yq '.coverage-report-paths' "$INPUT_CONFIGFILEPATH")

    # Set the variables based on configuration file
    INPUT_ROOTDIR=${CONFIG_ROOT_DIR:-$INPUT_ROOTDIR}
    INPUT_FAILONERROR=${CONFIG_FAIL_ON_ERROR:-$INPUT_FAILONERROR}
    INPUT_LANGUAGE=${CONFIG_LANGUAGE:-$INPUT_LANGUAGE}
    INPUT_BUILDSYSTEM=${CONFIG_BUILD_SYSTEM:-$INPUT_BUILDSYSTEM}
    INPUT_TESTREPORTSROOT=${CONFIG_TEST_REPORTS_ROOT:-$INPUT_TESTREPORTSROOT}
    INPUT_COVERAGELIB=${CONFIG_COVERAGE_LIB:-$INPUT_COVERAGELIB}
    INPUT_COVERAGEREPORTPATHS=${CONFIG_COVERAGE_REPORT_PATHS:-$INPUT_COVERAGEREPORTPATHS}

    echo "INPUT_ROOTDIR:$INPUT_ROOTDIR"
    echo "INPUT_LANGUAGE:$INPUT_LANGUAGE"
    echo "INPUT_COVERAGEREPORTPATHS:$INPUT_COVERAGEREPORTPATHS"

  else
    echo "No custom configuration provided. Using default configuration"
    exit 1
  fi
fi
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

if [ -n "$INPUT_SERVERURL" ]; then
    APP_ARGS="$APP_ARGS --serverUrl=$INPUT_SERVERURL"
fi

# Handle additional config-based inputs
if [ -n "$INPUT_ROOTDIR" ]; then
    APP_ARGS="$APP_ARGS --rootDir=$INPUT_ROOTDIR"
fi

if [ -n "$INPUT_LANGUAGE" ]; then
    APP_ARGS="$APP_ARGS --language=$INPUT_LANGUAGE"
fi

if [ -n "$INPUT_BUILDSYSTEM" ]; then
    APP_ARGS="$APP_ARGS --build-system=$INPUT_BUILDSYSTEM"
fi

if [ -n "$INPUT_TESTREPORTSROOT" ]; then
    APP_ARGS="$APP_ARGS --test-reports-root=$INPUT_TESTREPORTSROOT"
fi

if [ -n "$INPUT_COVERAGELIB" ]; then
    APP_ARGS="$APP_ARGS --coverage-lib=$INPUT_COVERAGELIB"
fi

if [ -n "$INPUT_COVERAGEREPORTPATHS" ]; then
    APP_ARGS="$APP_ARGS --coverage-report-paths=$INPUT_COVERAGEREPORTPATHS"
fi

# Append remaining application arguments
APP_ARGS="$APP_ARGS -v=GitHub -t=${INPUT_TOKEN}"

# Construct the full command with JVM options and application arguments
CMD="java $JVM_OPTS -jar /hubble-scanner.jar $APP_ARGS"

# Execute the command
eval "$CMD"
