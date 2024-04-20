Create Query
Command:
```shell
curl --request POST \
  --url https://api.dune.com/api/v1/query \
  --header 'Content-Type: application/json' \
  --header 'X-DUNE-API-KEY: <API_KEY>' \
  --data '{
  "name": "<QUERY_TITLE>",
  "description": "<QUERY_DESCRIPTION>",
  "parameters": [],
  "query_sql": "<QUERY_SQL>",
  "is_private": true
}'
```
Example Response:
```json
{"query_id":3650723}
```

Command:
```shell
curl --request GET \
  --url https://api.dune.com/api/v1/query/<QUERY_ID> \
  --header 'X-DUNE-API-KEY: <QUERY_TITLE>'
```
Example Response:
```json
{
    "query_id": 3650723,
    "name": "Acala Transaction Distribution by Type",
    "description": "",
    "tags": [],
    "version": 1,
    "parameters": [],
    "query_engine": "v2 Dune SQL",
    "query_sql": "SELECT * FROM acala.extrinsics LIMIT 10",
    "is_private": true,
    "is_archived": false,
    "is_unsaved": false,
    "owner": "substrate"
}
```

Command:
```shell
curl --request PATCH \
  --url https://api.dune.com/api/v1/query/<QUERY_ID> \
  --header 'Content-Type: application/json' \
  --header 'X-DUNE-API-KEY: <API_KEY>' \
  --data '{
  "query_sql": "<QUERY_SQL>"
}'
```
Example Response:
```json
{"query_id":3650723}
```

Command:
```shell
curl --request POST \
  --url "https://api.dune.com/api/v1/query/<QUERY_ID>/execute" \
  --header 'Content-Type: application/json' \
  --header 'X-DUNE-API-KEY: <API_KEY>' \
  --data '{
    "performance": "medium"
  }'
```
Example Response:
```json
{"execution_id":"01HVXYYH720CWWJV283Q0B191B","state":"QUERY_STATE_PENDING"}
```

Command:
```shell
curl -X POST -H x-dune-api-key:<API_KEY> "https://api.dune.com/api/v1/execution/<EXECUTION_ID>/cancel"
```
Example Response:
```json

```

Command:
```shell
curl -X GET "https://api.dune.com/api/v1/execution/<EXECUTION_ID>/status" -H x-dune-api-key:<API_KEY>
```
Example Response:
```json
{
    "execution_id": "01HVXYYH720CWWJV283Q0B191B",
    "query_id": 3650723,
    "is_execution_finished": true,
    "state": "QUERY_STATE_COMPLETED",
    "submitted_at": "2024-04-20T14:35:45.762606Z",
    "expires_at": "2024-07-19T14:35:47.35358Z",
    "execution_started_at": "2024-04-20T14:35:46.401995513Z",
    "execution_ended_at": "2024-04-20T14:35:47.3535789Z",
    "result_metadata": {
        "column_names": [
            "year",
            "month",
            "section",
            "method",
            "block_time",
            "block_number",
            "extrinsic_id",
            "hash",
            "block_hash",
            "lifetime",
            "params",
            "fee",
            "weight",
            "signed",
            "signer_ss58",
            "signer_pub_key",
            "status",
            "updated_at",
            "ingested_at"
        ],
        "row_count": 1000,
        "result_set_bytes": 602585,
        "total_row_count": 1000,
        "total_result_set_bytes": 602585,
        "datapoint_count": 19000,
        "pending_time_millis": 639,
        "execution_time_millis": 951
    }
}
```

Command:
```shell
curl -X GET "https://api.dune.com/api/v1/execution/<EXECUTION_ID>/results?limit=100" -H x-dune-api-key:<API_KEY>
```
Example Response:
```json
{
    "execution_id": "01HVXYYH720CWWJV283Q0B191B",
    "query_id": 3650723,
    "is_execution_finished": true,
    "state": "QUERY_STATE_COMPLETED",
    "submitted_at": "2024-04-20T14:35:45.762606Z",
    "expires_at": "2024-07-19T14:35:47.35358Z",
    "execution_started_at": "2024-04-20T14:35:46.401995Z",
    "execution_ended_at": "2024-04-20T14:35:47.353578Z",
    "result": {
        "rows": [
            {
                "block_hash": "0x38f52d348021c958ea1cfa7aa0574dadfa5611ad51bcac820167c55f4807211c",
                "block_number": 265601,
                "block_time": "2022-01-25 07:00:12.000 UTC",
                "extrinsic_id": "265601-14",
                "fee": 0.007032674506,
                "hash": "0xb06590d96407655e5d81b91a81e4e09fb73181f8f2a70edf13f92c26cfb4b692",
                "ingested_at": "2024-04-10 17:52:50.042 UTC",
                "lifetime": "{\"birth\":265597,\"death\":265629,\"isImmortal\":0}",
                "method": "cancelAsMulti",
                "month": 1,
                "params": "{\"call_hash\":\"0xff24c65e96728d24acc786d8f48e14dc55f589420209991f49c5229856c776e0\",\"other_signatories\":[\"2178atDGSUQMt82pkeEuPCG8s46kXPxmJeaYx9g4KnroHrZC\",\"21HXsPkMUspue6rAJghTKw1VVojXqYSbB8oAaf4zXBoAqYNt\",\"227JSRgV18yzo3f3mGj9e2gr1DE9jx1RmCXAx3Th5BJ24HiK\",\"22dyeo9EWELVXwToJJ94XewuGQKNdJjjxMaNvyoNZxoV462H\",\"22o3S5DVVt9LRGK1HyYBMBxa7NCkfJCTkfBVRn7ctJKaPiFh\",\"22t4FoCvwqCW3VdvoZC1EdphoMUKUDtadeXENJzwiwwTQWWQ\",\"23hM6rRYkRULUVMwydzBqxjdGYbLKWcLp7qEiTcDcjFeWHs3\",\"23rqmxTJEkTAHkLiYjCe51ohgckA7dcyYKZud1tfBLFyLfk8\",\"24J9ASqUgVu7xRQDDpcFFaAH5qq3BBfUF1UDun6jJG3dwgXb\",\"24KFqzNdfdxWETd91azK4mqD4vP3VSTt6ZV8zgC7pYLytpXV\",\"24Y98NPdVBpdujufBsn1QMGGYQwiUkSq9FBEtPVjwQJYm8ti\",\"24eY2C3jUkuRcQKSNmKFfXM9iGfpVMCp4HPRuSicGRbzUoGk\",\"25zTKRhiYQgSrf5R3TfcXrWL4BL2UeuuV1gWLe9epFSPv4RJ\"],\"threshold\":9,\"timepoint\":{\"height\":265597,\"index\":611}}",
                "section": "multisig",
                "signed": true,
                "signer_pub_key": "0x3eba41a7643673957c14112a0e83bf4b1deaa4aa6386ff44bcc198eaedcd413a",
                "signer_ss58": "22HqtEq6povQioiKFF48nKAp745KSYXAz7cVWguNS4veCwor",
                "status": true,
                "updated_at": "2024-03-31 23:28:03.492 UTC",
                "weight": 338468000,
                "year": 2022
            },
            {
                "block_hash": "0x62e45af03bbd6f2fd863ec2aab6abb9eaee8a45f82a4ec1b0d96be221bd67aef",
                "block_number": 266596,
                "block_time": "2022-01-25 11:01:01.000 UTC",
                "extrinsic_id": "266596-12",
                "fee": 0.004469262481,
                "hash": "0xb3e2417417c59855046b7efa010b5c7b39a2a0e6b0b91ff6c4a4611ba45c7862",
                "ingested_at": "2024-04-10 17:52:50.042 UTC",
                "lifetime": "{\"birth\":266592,\"death\":266624,\"isImmortal\":0}",
                "method": "cancelAsMulti",
                "month": 1,
                "params": "{\"call_hash\":\"0xfb3b50dcb1284e59695e3050039782820408196ac5a60baf3cffd30b65d2f432\",\"other_signatories\":[\"23RDJ7SyVgpKqC6M9ad8wvbBsbSr3R4Xqr5NQAKEhWPHbLbs\",\"249QskFMEcb5WcgHF7BH5MesVGHq3imsUACq2RPgtBBdCPMa\",\"263KsUutx8qhRmG7hq6fEaSKE3fdi3KeeEKafkAMJ1cg1AYc\",\"26SUM8AN5MKefKCFiPDapUcQwHNfNzWYMyfUSVcqiFV2JYWc\",\"26VNG6LyuRag3xfuck7eoAjKk4ZLg9GeN6LDjxMw4ib3E8yg\"],\"threshold\":3,\"timepoint\":{\"height\":266585,\"index\":10}}",
                "section": "multisig",
                "signed": true,
                "signer_pub_key": "0xbc517c01c4b663efdfea3dd9ab71bdc3ea607e8a35ba3d1872e5b0942821cd2f",
                "signer_ss58": "258WnzxhgwXuDL7w3Hag8TMCqb79dAUvRrMJd9kqJ9CzDf7v",
                "status": true,
                "updated_at": "2024-03-31 23:28:17.464 UTC",
                "weight": 337140000,
                "year": 2022
            },
            ...
        ],
        "metadata": {
            "column_names": [
                "year",
                "month",
                "section",
                "method",
                "block_time",
                "block_number",
                "extrinsic_id",
                "hash",
                "block_hash",
                "lifetime",
                "params",
                "fee",
                "weight",
                "signed",
                "signer_ss58",
                "signer_pub_key",
                "status",
                "updated_at",
                "ingested_at"
            ],
            "row_count": 1000,
            "result_set_bytes": 602585,
            "total_row_count": 1000,
            "total_result_set_bytes": 602585,
            "datapoint_count": 19000,
            "pending_time_millis": 639,
            "execution_time_millis": 951
        }
    }
}
```

Command:
```shell
curl -X GET "https://api.dune.com/api/v1/execution/<EXECUTION_ID>/results/csv?limit=100" -H x-dune-api-key:<API_KEY>
```
Example Response:
```csv
year,month,section,method,block_time,block_number,extrinsic_id,hash,block_hash,lifetime,params,fee,weight,signed,signer_ss58,signer_pub_key,status,updated_at,ingested_at
2022,1,multisig,cancelAsMulti,2022-01-25 07:00:12.000 UTC,265601,265601-14,0xb06590d96407655e5d81b91a81e4e09fb73181f8f2a70edf13f92c26cfb4b692,0x38f52d348021c958ea1cfa7aa0574dadfa5611ad51bcac820167c55f4807211c,"{""birth"":265597,""death"":265629,""isImmortal"":0}","{""call_hash"":""0xff24c65e96728d24acc786d8f48e14dc55f589420209991f49c5229856c776e0"",""other_signatories"":[""2178atDGSUQMt82pkeEuPCG8s46kXPxmJeaYx9g4KnroHrZC"",""21HXsPkMUspue6rAJghTKw1VVojXqYSbB8oAaf4zXBoAqYNt"",""227JSRgV18yzo3f3mGj9e2gr1DE9jx1RmCXAx3Th5BJ24HiK"",""22dyeo9EWELVXwToJJ94XewuGQKNdJjjxMaNvyoNZxoV462H"",""22o3S5DVVt9LRGK1HyYBMBxa7NCkfJCTkfBVRn7ctJKaPiFh"",""22t4FoCvwqCW3VdvoZC1EdphoMUKUDtadeXENJzwiwwTQWWQ"",""23hM6rRYkRULUVMwydzBqxjdGYbLKWcLp7qEiTcDcjFeWHs3"",""23rqmxTJEkTAHkLiYjCe51ohgckA7dcyYKZud1tfBLFyLfk8"",""24J9ASqUgVu7xRQDDpcFFaAH5qq3BBfUF1UDun6jJG3dwgXb"",""24KFqzNdfdxWETd91azK4mqD4vP3VSTt6ZV8zgC7pYLytpXV"",""24Y98NPdVBpdujufBsn1QMGGYQwiUkSq9FBEtPVjwQJYm8ti"",""24eY2C3jUkuRcQKSNmKFfXM9iGfpVMCp4HPRuSicGRbzUoGk"",""25zTKRhiYQgSrf5R3TfcXrWL4BL2UeuuV1gWLe9epFSPv4RJ""],""threshold"":9,""timepoint"":{""height"":265597,""index"":611}}",0.007032674506,3.38468e+08,true,22HqtEq6povQioiKFF48nKAp745KSYXAz7cVWguNS4veCwor,0x3eba41a7643673957c14112a0e83bf4b1deaa4aa6386ff44bcc198eaedcd413a,true,2024-03-31 23:28:03.492 UTC,2024-04-10 17:52:50.042 UTC
2022,1,multisig,cancelAsMulti,2022-01-25 11:01:01.000 UTC,266596,266596-12,0xb3e2417417c59855046b7efa010b5c7b39a2a0e6b0b91ff6c4a4611ba45c7862,0x62e45af03bbd6f2fd863ec2aab6abb9eaee8a45f82a4ec1b0d96be221bd67aef,"{""birth"":266592,""death"":266624,""isImmortal"":0}","{""call_hash"":""0xfb3b50dcb1284e59695e3050039782820408196ac5a60baf3cffd30b65d2f432"",""other_signatories"":[""23RDJ7SyVgpKqC6M9ad8wvbBsbSr3R4Xqr5NQAKEhWPHbLbs"",""249QskFMEcb5WcgHF7BH5MesVGHq3imsUACq2RPgtBBdCPMa"",""263KsUutx8qhRmG7hq6fEaSKE3fdi3KeeEKafkAMJ1cg1AYc"",""26SUM8AN5MKefKCFiPDapUcQwHNfNzWYMyfUSVcqiFV2JYWc"",""26VNG6LyuRag3xfuck7eoAjKk4ZLg9GeN6LDjxMw4ib3E8yg""],""threshold"":3,""timepoint"":{""height"":266585,""index"":10}}",0.004469262481,3.3714e+08,true,258WnzxhgwXuDL7w3Hag8TMCqb79dAUvRrMJd9kqJ9CzDf7v,0xbc517c01c4b663efdfea3dd9ab71bdc3ea607e8a35ba3d1872e5b0942821cd2f,true,2024-03-31 23:28:17.464 UTC,2024-04-10 17:52:50.042 UTC
```

Command:
```shell
curl --request GET --url https://api.dune.com/api/v1/query/<QUERY_ID>/results/csv?limit=100 -H x-dune-api-key:<API_KEY>
```
Example Response
```csv
(same as last)
```