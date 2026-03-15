CREATE TABLE IF NOT EXISTS server_logs
(
    timestamp DateTime,
    user_id UInt32,
    endpoint String,
    response_time_ms UInt32,
    status_code UInt16
) ENGINE = MergeTree()
ORDER BY (timestamp,endpoint);

select
    endpoint,
    round(avg(response_time_ms), 2) as avg_response_time
from server_logs
group by endpoint
order by avg_response_time desc
limit 5;

select
    toHour(timestamp) as hour,
    count(*) as request_count
from server_logs
group by hour
order by hour;

select
    endpoint,
    round((countIf(status_code >= 400) / count(*)) * 100, 2) as error_percentage
from server_logs
group by endpoint
order by error_percentage desc;
