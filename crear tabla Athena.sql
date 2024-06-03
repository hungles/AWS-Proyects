#Crear tabla para consultar los datos en Athena

CREATE EXTERNAL TABLE IF NOT EXISTS web_logs (
    ip_address STRING,
    timestamp STRING,
    request STRING,
    response_code INT,
    user_agent STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar' = '\"'
)
LOCATION 's3://ruta_al_bucket/';
