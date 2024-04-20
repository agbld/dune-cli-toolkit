-- query_id: 3651835

SELECT
    block_time,
    section,
    method,
    extrinsic_id,
    data_decoded
FROM
    acala.events
LIMIT 100
