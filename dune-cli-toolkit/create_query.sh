#!/bin/bash

# 獲取當前腳本目錄
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# 從 config.json 讀取API鍵
CONFIG_FILE="$SCRIPT_DIR/config.json"
API_KEY=$(jq -r '.api_key' "$CONFIG_FILE")

# 檢查API鍵是否存在
if [ -z "$API_KEY" ]; then
    echo "API key not found in config.json"
    exit 1
fi

# 使用者輸入的參數
QUERY_TITLE="${1:-Default Query}"
QUERY_DESCRIPTION="${2:- }"
QUERY_SQL="${3:- }"

# 使用用戶提供的參數創建查詢
curl --request POST \
  --url https://api.dune.com/api/v1/query \
  --header "Content-Type: application/json" \
  --header "X-DUNE-API-KEY: $API_KEY" \
  --data '{
    "name": "'"${QUERY_TITLE}"'",
    "description": "'"${QUERY_DESCRIPTION}"'",
    "parameters": [],
    "query_sql": "'"${QUERY_SQL}"'",
    "is_private": true
  }'
