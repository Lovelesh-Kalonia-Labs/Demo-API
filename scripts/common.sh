#!/bin/bash

set -e

get_json_value() {
jq -r "$1" "$CONFIG_FILE"
}

get_project_version() {
mvn help:evaluate -Dexpression=project.version -q -DforceStdout
}

get_artifact_id() {
mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout
}

generate_app_name() {

VERSION=$(get_project_version)

ARTIFACT_ID=$(get_artifact_id)

echo "${ENVIRONMENT}-${ARTIFACT_ID}-${VERSION}" \
| tr '[:upper:]' '[:lower:]' \
| sed 's/[^a-z0-9-]/-/g'
}
