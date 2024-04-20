#!/bin/bash

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--pull) pull="yes"; shift ;;
        *) SQL_FILE_PATH="$1"; shift ;;
    esac
done

# 讀取配置文件以獲取API鍵
CONFIG_FILE="config.json"
API_KEY=$(jq -r '.api_key' "$CONFIG_FILE")

# 檢查API鍵是否存在
if [ -z "$API_KEY" ]; then
    echo "API key not found in config.json"
    exit 1
fi

# 檢查是否有提供SQL檔案路徑
if [ -z "$SQL_FILE_PATH" ]; then
    echo "SQL file path is required as the first or second argument."
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

# 使用curl發送GET請求來獲取查詢詳情
RESPONSE=$(curl --silent --request GET \
  --url "https://api.dune.com/api/v1/query/$QUERY_ID" \
  --header "X-DUNE-API-KEY: $API_KEY")

if [[ "$pull" == "yes" ]]; then
    # 從回應中提取SQL查詢
    NEW_QUERY_SQL=$(echo "$RESPONSE" | jq -r '.query_sql')

    # 寫入新的SQL到文件
    echo "$NEW_QUERY_SQL" > "$SQL_FILE_PATH"
    echo "Updated SQL file at $SQL_FILE_PATH with latest query from server."
else
    echo "$RESPONSE"
fi
