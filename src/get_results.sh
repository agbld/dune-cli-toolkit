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

# 使用者輸入的參數：SQL檔案的路徑
SQL_FILE_PATH="${1}"

# 檢查是否有提供SQL檔案路徑
if [ -z "$SQL_FILE_PATH" ]; then
    echo "SQL file path is required as the first argument."
    exit 1
fi

# CSV檔案路徑
CSV_FILE="$SCRIPT_DIR/.execution_state.csv"

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

# 確定CSV結果文件的儲存目錄和檔案名
RESULTS_DIR=$(dirname "$SQL_FILE_PATH")/csv_results
RESULTS_FILE="$RESULTS_DIR/$(basename "$SQL_FILE_PATH" .sql).csv"

# 創建存儲目錄，如果它不存在
mkdir -p "$RESULTS_DIR"

# 使用curl發送GET請求來獲取查詢結果，並將結果儲存到CSV文件
curl --silent --request GET \
  --url "https://api.dune.com/api/v1/execution/$EXECUTION_ID/results/csv?limit=100" \
  --header "X-DUNE-API-KEY: $API_KEY" > "$RESULTS_FILE"

echo "Results saved to $RESULTS_FILE"
