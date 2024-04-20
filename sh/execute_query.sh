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

# 從檔案讀取查詢ID
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

# 使用curl發送POST請求來執行查詢
RESPONSE=$(curl --silent --request POST \
  --url "https://api.dune.com/api/v1/query/$QUERY_ID/execute" \
  --header "Content-Type: application/json" \
  --header "X-DUNE-API-KEY: $API_KEY" \
  --data '{"performance": "medium"}')

# 從響應中提取execution_id
EXECUTION_ID=$(echo "$RESPONSE" | jq -r '.execution_id')

# CSV檔案路徑，更新為.execution_state.csv
CSV_FILE=".execution_state.csv"

# 檢查CSV檔是否存在，如果不存在，創建檔案並添加標題
if [ ! -f "$CSV_FILE" ]; then
    echo "sql_file,execution_id,state" > "$CSV_FILE"
fi

# 檢查CSV檔中是否已有該SQL檔案的記錄
if grep -q "$(basename "$SQL_FILE_PATH")" "$CSV_FILE"; then
    # 更新現有記錄
    sed -i "s|$(basename "$SQL_FILE_PATH").*,.*,.*|$(basename "$SQL_FILE_PATH"),$EXECUTION_ID,INIT|" "$CSV_FILE"
else
    # 添加新記錄
    echo "$(basename "$SQL_FILE_PATH"),$EXECUTION_ID,INIT" >> "$CSV_FILE"
fi

# 輸出執行ID以供用戶確認
echo "Execution ID for $(basename "$SQL_FILE_PATH"): $EXECUTION_ID"
