-- query_id: 3650864

SELECT
    block_time,
    section,
    method,
    extrinsic_id,
    params,
    signer_ss58
FROM
    acala.extrinsics
LIMIT 100