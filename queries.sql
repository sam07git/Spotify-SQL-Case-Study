CREATE DATABASE spotify_analysis;
USE spotify_analysis;
SELECT * FROM spotify_user_behavior_realistic_50000_rows LIMIT 5;

select count(*) from spotify_user_behavior_realistic_50000_rows

DESCRIBE spotify_user_behavior_realistic_50000_rows

Select Count(distinct country) from spotify_user_behavior_realistic_50000_rows

"What are different subscription types?"
SELECT subscription_type, COUNT(*) AS users
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type


" Which subscription type listens more? "
SELECT subscription_type, 
AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type
order by avg_hours desc
limit 1

SELECT subscription_type, COUNT(*) AS total_users
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type
ORDER BY total_users DESC;

Select AVG(avg_skips_per_day) as avgg, subscription_type
from spotify_user_behavior_realistic_50000_rows
where subscription_type in("free","premium individual")
GROUP BY subscription_type
order by avgg desc

"Write query for:Avg skips per day by subscription type"
Select 
case
WHEN subscription_type = 'Free' THEN 'Free'
        ELSE 'Premium'
end as subscritionType,
AVG(avg_skips_per_day) as avgg
from spotify_user_behavior_realistic_50000_rows
GROUP BY subscritionType;

"Free users skip more songs compared to Premium users, indicating lower engagement quality despite higher listening hours."
SELECT 
    CASE 
        WHEN subscription_type = 'Free' THEN 'Free'
        ELSE 'Premium'
    END AS user_type,
    AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY user_type;



"Do skips affect inactivity?"

SELECT inactive_3_months_flag,
       AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

"Skipping behavior is almost the same for active and inactive users, so it is not a strong factor influencing inactivity"

SELECT inactive_3_months_flag,
       AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

SELECT inactive_3_months_flag,
       AVG(playlists_created) AS avg_playlists
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

SELECT inactive_3_months_flag,
       AVG(ad_interaction = 'Yes') AS ad_interaction_rate
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

SELECT inactive_3_months_flag,
       AVG(music_suggestion_rating_1_to_5) AS avg_rating
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

 "Age vs engagement Part 1"
Select age, avg(avg_listening_hours_per_week) as result
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY age
order by result desc;

 "Age vs engagement Part 2"
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS users,
    AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY age_group
order by avg_hours desc

"Age vs Subscription"

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group,
    subscription_type,
    COUNT(*) AS users
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY age_group, subscription_type
ORDER BY age_group, users DESC;

SELECT *
FROM (
    SELECT 
        CASE 
            WHEN age BETWEEN 18 AND 25 THEN '18-25'
            WHEN age BETWEEN 26 AND 35 THEN '26-35'
            WHEN age BETWEEN 36 AND 50 THEN '36-50'
            ELSE '50+'
        END AS age_group,
        subscription_type,
        COUNT(*) AS users,
        RANK() OVER (PARTITION BY 
            CASE 
                WHEN age BETWEEN 18 AND 25 THEN '18-25'
                WHEN age BETWEEN 26 AND 35 THEN '26-35'
                WHEN age BETWEEN 36 AND 50 THEN '36-50'
                ELSE '50+'
            END
        ORDER BY COUNT(*) DESC) AS rnk
    FROM spotify_user_behavior_realistic_50000_rows
    GROUP BY age_group, subscription_type
) t
WHERE rnk = 1;

"Top genres by listening
Genre vs skips"
SELECT favorite_genre,
       AVG(avg_listening_hours_per_week) AS avg_hours,
       AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY favorite_genre
ORDER BY avg_hours DESC;
