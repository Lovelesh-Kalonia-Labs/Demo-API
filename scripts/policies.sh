#!/bin/bash

set -e

POLICY_EXISTS=$(anypoint-cli-v4 api-mgr:policy:list 
"$API_INSTANCE_ID" 
--output json 
| jq -r '.[] | select(.policyTemplateId=="client-id-enforcement") | .id')

if [ -z "$POLICY_EXISTS" ]; then

echo "Applying Client ID Enforcement..."

anypoint-cli-v4 api-mgr:policy:apply 
"$API_INSTANCE_ID" 
client-id-enforcement

else

echo "Policy already exists."

fi
