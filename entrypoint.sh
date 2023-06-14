#!/bin/sh -l

set -e

echo GitHub repository       :  "${GITHUB_REPOSITORY}"
echo GitHub repository owner :  "${GITHUB_REPOSITORY_OWNER}"
echo GitHub ref              : "${GITHUB_REF}"
echo GitHub head ref         :  "${GITHUB_HEAD_REF}"
echo GitHub base ref         :  "${GITHUB_BASE_REF}"
echo GitHub sha              :  "${GITHUB_SHA}"
echo GitHub ref name         :  "${GITHUB_REF_NAME}"
echo GitHub ref type         :  "${GITHUB_REF_TYPE}"
echo GitHub action           :  "${GITHUB_ACTION}"
echo GitHub action repo      :  "${GITHUB_ACTION_REPOSITORY}"
echo GitHub action ref       :  "${GITHUB_ACTION_REF}"
echo GitHub actor            :  "${GITHUB_ACTOR}"


APP_OPTS=
APP_OPTS="$APP_OPTS -Dspring.profiles.active=prod"

java $APP_OPTS -jar /cq-scanner-app.jar -l="${INPUT_SOURCELANGUAGE}" -t="$INPUT_AUTHTOKEN" -k="${INPUT_PROJECTKEY}"
