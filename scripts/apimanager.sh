#!/bin/bash

set -e

source scripts/common.sh

ASSET_ID=$(get_json_value '.exchangeApi.assetId')
ASSET_VERSION=$(get_json_value '.exchangeApi.version')
API_VERSION=$(get_json_value '.exchangeApi.apiVersion')

APP_NAME=$(get_artifact_id)

INSTANCE_TEMPLATE=$(get_json_value '.apiManager.instanceLabelTemplate')

INSTANCE_LABEL=${INSTANCE_TEMPLATE//${ENV}/$ENVIRONMENT}
INSTANCE_LABEL=${INSTANCE_LABEL//${APP_NAME}/$APP_NAME}
INSTANCE_LABEL=${INSTANCE_LABEL//${API_VERSION}/$API_VERSION}

echo "Searching API Instance..."

API_INSTANCE_ID=$(anypoint-cli-v4 api-mgr:api:list 
--output json 
| jq -r ".[] | select(.assetId=="$ASSET_ID") | .id" 
| head -1)

if [ -z "$API_INSTANCE_ID" ]; then

echo "Creating API Manager Instance..."

anypoint-cli-v4 api-mgr:api:manage 
"$ASSET_ID" 
"$ASSET_VERSION" 
--muleVersion4OrAbove 
--apiInstanceLabel "$INSTANCE_LABEL"

sleep 15

API_INSTANCE_ID=$(anypoint-cli-v4 api-mgr:api:list 
--output json 
| jq -r ".[] | select(.assetId=="$ASSET_ID") | .id" 
| head -1)

fi

echo "API_INSTANCE_ID=$API_INSTANCE_ID" >> $GITHUB_ENV

echo "API Instance ID = $API_INSTANCE_ID"
