create keyspace users_posts 
with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

use users_posts;

create table posts_by_users (
    user_id int,
    created_at timestamp,
    post_id int,
    content text,
    primary key(user_id, created_at, post_id)
)with clustering order by( created_at desc, post_id asc);

create table posts_by_date_topic (
    date_posting date,
    topic_id int,
    created_at timestamp,
    user_id int,
    post_id int,
    username text,
    primary key ((date_posting, topic_id),created_at, post_id)
)with clustering order by (created_at desc, user_id asc, post_id asc);

select post_id, content, created_at
from posts_by_users
where user_id= 1;

select post_id, content, created_at, username
from posts_by_users
where user_id =2
limit 1;

select post_id, content, created_at
from posts_by_users
where user_id = 3 and created_at >='2026-03-10';

select user_id, username, post_id,created_at
from posts_by_date_topic
where date_posting = '2026-03-11' and topic_id = 3;
