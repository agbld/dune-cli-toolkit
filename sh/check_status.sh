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

# CSV檔案路徑
CSV_FILE=".execution_state.csv"

# 檢查CSV檔案是否存在
if [ ! -f "$CSV_FILE" ]; then
    echo "CSV mapping file does not exist. Please execute a query first."
    exit 1
fi

# 從CSV檔中讀取execution_id
EXECUTION_ID=$(grep "$(basename "$SQL_FILE_PATH")" "$CSV_FILE" | cut -d ',' -f2)

# 檢查是否找到execution_id
if [ -z "$EXECUTION_ID" ]; then
    echo "No execution ID found for $(basename "$SQL_FILE_PATH"). Please execute the query first."
    exit 1
fi

# 使用curl發送GET請求來獲取執行狀態
RESPONSE=$(curl --silent --request GET \
  --url "https://api.dune.com/api/v1/execution/$EXECUTION_ID/status" \
  --header "X-DUNE-API-KEY: $API_KEY")

# 從響應中提取state
NEW_STATE=$(echo "$RESPONSE" | jq -r '.state')

# 更新CSV文件中的state
sed -i "s|$(basename "$SQL_FILE_PATH"),$EXECUTION_ID,.*|$(basename "$SQL_FILE_PATH"),$EXECUTION_ID,$NEW_STATE|" "$CSV_FILE"

# 輸出執行狀態以供用戶確認
echo "Execution state for $(basename "$SQL_FILE_PATH"): $NEW_STATE"
