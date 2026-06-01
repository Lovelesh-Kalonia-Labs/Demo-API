#!/bin/bash

set -e

source scripts/common.sh

SLA_NAME=$(get_json_value '.sla.name')
SLA_DESCRIPTION=$(get_json_value '.sla.description')
AUTO_APPROVE=$(get_json_value '.sla.autoApprove')

VISIBLE=$(get_json_value '.sla.limits[0].visible')
MAX_REQUESTS=$(get_json_value '.sla.limits[0].maximumRequests')
TIME_UNIT=$(get_json_value '.sla.limits[0].timeUnit')

echo "Checking SLA Tier..."

TIER_ID=$(anypoint-cli-v4 api-mgr:tier:list 
"$API_INSTANCE_ID" 
--output json 
| jq -r ".[] | select(.name=="$SLA_NAME") | .id" 
| head -1)

if [ -z "$TIER_ID" ]; then

echo "Creating SLA Tier..."

anypoint-cli-v4 api-mgr:tier:add 
"$API_INSTANCE_ID" 
--name "$SLA_NAME" 
--description "$SLA_DESCRIPTION" 
--limit "$VISIBLE,$MAX_REQUESTS,$TIME_UNIT"

if [ "$AUTO_APPROVE" = "true" ]; then

```
anypoint-cli-v4 api-mgr:tier:add \
  "$API_INSTANCE_ID" \
  --name "$SLA_NAME" \
  --description "$SLA_DESCRIPTION" \
  --autoApprove \
  --limit "$VISIBLE,$MAX_REQUESTS,$TIME_UNIT"
```

fi

else

echo "SLA Tier already exists."

fi
