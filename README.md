# dune-cli-toolkit
Execute queries and see results with CLI. Design for integrate dune.com with VSCode IDE.

⚠️ WARNING: This tool is under development. Use it at your own risk.
⚠️ WARNING: All execution will be run with at least **medium** engine. You will be charged for the execution. For more information, please check [Dune API Doc](https://docs.dune.com/api-reference/executions/endpoint/execute-query).

## Installation
1. Clone this repository
2. Get your API key from [Dune](https://dune.com/)
3. Create a `config.json` file in the `dune-cli-toolkit` directory with the following content:
    ```json
    {
        "api_key": "YOUR_API_KEY"
    }
    ```
4. Move the `dune-cli-toolkit` directory to the path you want to install the tool, for example:
    ```bash
    mv -r dune-cli-toolkit ~/dune-cli-toolkit
    ```
    You can also leave it in the cloned directory.

## Usage
### Get Existing Query From Dune
Get (or pull) an existing query from Dune. Please follow the steps below:
1. Choose a query from Dune, and add a comment (with Dune editor) with the query ID at the beginning of the query.
    ```sql
    -- query_id: [YOUR_QUERY_ID]
    WITH
        some_cte AS (
            ...
        )
    SELECT 
        ...
    FROM 
        some_table
    WHERE 
        some_condition
    ```
2. Create a `[YOUR_QUERY_TITLE].sql` file in where you want to keep it **with EXACTLY the following content**:
    ```sql
    -- query_id: [YOUR_QUERY_ID]
    ```
3. Run the following command in the terminal:
    ```bash
    bash [PATH_TO_DUNE_CLI_TOOLKIT]/get_query.sh [PATH_TO_YOUR_QUERY_FILE]
    ```
    After running the command, you will see the query content in the `[YOUR_QUERY_TITLE].sql` file.

**NOTE:** The `get_query.sh` script is still under development. It will be more user-friendly in the future.

## Update, Run and See Query Results
You can do these all automatically with the following command:
```bash
bash [PATH_TO_DUNE_CLI_TOOLKIT]/update_and_execute.sh [PATH_TO_YOUR_QUERY_FILE]
```
It will update (push) the query from local to Dune, start execution, check the status in every 3 seconds, and get the results when the execution is completed. **The results will be saved in the `csv_results` directory under the same directory with the query file.**

Or you can do these steps manually:
1. Update (push) the query from local to Dune:
    ```bash
    bash [PATH_TO_DUNE_CLI_TOOLKIT]/update_query.sh [PATH_TO_YOUR_QUERY_FILE]
    ```
2. Start execution:
    ```bash
    bash [PATH_TO_DUNE_CLI_TOOLKIT]/execute_query.sh [PATH_TO_YOUR_QUERY_FILE]
    ```
3. Check the execution status:
    ```bash
    bash [PATH_TO_DUNE_CLI_TOOLKIT]/check_status.sh [PATH_TO_YOUR_QUERY_FILE]
    ```
4. Save the .csv results to the `csv_results` directory:
    ```bash
    bash [PATH_TO_DUNE_CLI_TOOLKIT]/get_results.sh [PATH_TO_YOUR_QUERY_FILE]
    ```