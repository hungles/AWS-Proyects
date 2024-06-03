#Consultar por los codigos http en archivos txt formateados en CSV con Athena

SELECT ip_address, COUNT(*) as request_count
FROM web_logs
WHERE response_code = 200
GROUP BY ip_address
ORDER BY request_count DESC;
