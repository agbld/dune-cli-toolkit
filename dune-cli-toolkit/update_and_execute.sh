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

# 更新查詢
./update_query.sh "$SQL_FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to update query."
    exit 1
fi

# 執行查詢
./execute_query.sh "$SQL_FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to execute query."
    exit 1
fi

# 從CSV檔案獲取執行ID
CSV_FILE=".execution_state.csv"
EXECUTION_ID=$(grep "$(basename "$SQL_FILE_PATH")" "$CSV_FILE" | cut -d ',' -f2)

# 循環檢查執行狀態
while true; do
    sleep 3  # 每隔10秒檢查一次狀態

    # 檢查執行狀態
    ./check_status.sh "$SQL_FILE_PATH"
    CURRENT_STATE=$(grep "$(basename "$SQL_FILE_PATH")" "$CSV_FILE" | cut -d ',' -f3)

    echo "Current state: $CURRENT_STATE"

    # 如果查詢完成，則獲取結果
    if [ "$CURRENT_STATE" == "QUERY_STATE_COMPLETED" ]; then
        ./get_results.sh "$SQL_FILE_PATH"
        break
    fi
done

echo "Query completed and results are saved."
