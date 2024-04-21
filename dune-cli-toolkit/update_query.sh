#!/bin/bash

# 讀取配置文件以獲取API鍵
CONFIG_FILE="config.json"
API_KEY=$(jq -r '.api_key' "$CONFIG_FILE")

# 檢查API鍵是否存在
if [ -z "$API_KEY" ]; then
    echo "API key not found in config.json"
    exit 1
fi

# 使用者輸入的參數：SQL檔案的路徑
SQL_FILE_PATH="${1}"

# 檢查是否有提供SQL檔案路徑
if [ -z "$SQL_FILE_PATH" ]; then
    echo "SQL file path is required as the first argument."
    exit 1
fi

# 從檔案讀取查詢ID和新的SQL語句
if [ ! -f "$SQL_FILE_PATH" ]; then
    echo "SQL file does not exist: $SQL_FILE_PATH"
    exit 1
fi

# 從SQL檔案的第一行提取查詢ID
QUERY_ID=$(sed -n '1s/-- query_id: //p' "$SQL_FILE_PATH")

if [ -z "$QUERY_ID" ]; then
    echo "Query ID not found in the SQL file."
    exit 1
fi

# 讀取整個SQL檔案，包括註解
NEW_QUERY_SQL=$(cat "$SQL_FILE_PATH" | jq -Rs .)

# 使用curl發送PATCH請求來更新查詢
curl --request PATCH \
  --url "https://api.dune.com/api/v1/query/$QUERY_ID" \
  --header "Content-Type: application/json" \
  --header "X-DUNE-API-KEY: $API_KEY" \
  --data '{
    "query_sql": '"$NEW_QUERY_SQL"'
  }'
