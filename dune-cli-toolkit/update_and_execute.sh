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

# 更新查詢
$SCRIPT_DIR/update_query.sh "$SQL_FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to update query."
    exit 1
fi

# 執行查詢
$SCRIPT_DIR/execute_query.sh "$SQL_FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to execute query."
    exit 1
fi

# 從CSV檔案獲取執行ID
CSV_FILE="$SCRIPT_DIR/execution_state.csv"
EXECUTION_ID=$(grep "$(basename "$SQL_FILE_PATH")" "$CSV_FILE" | cut -d ',' -f2)

# 循環檢查執行狀態
while true; do
    sleep 3  # 每隔10秒檢查一次狀態

    # 檢查執行狀態
    $SCRIPT_DIR/check_status.sh "$SQL_FILE_PATH"
    CURRENT_STATE=$(grep "$(basename "$SQL_FILE_PATH")" "$CSV_FILE" | cut -d ',' -f3)

    echo "Current state: $CURRENT_STATE"

    # 如果查詢完成，則獲取結果
    if [ "$CURRENT_STATE" == "QUERY_STATE_COMPLETED" ]; then
        $SCRIPT_DIR/get_results.sh "$SQL_FILE_PATH"
        break
    fi
done

echo "Query completed and results are saved."
