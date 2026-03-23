-- =====================================================
-- 🎧 Spotify User Behavior Analysis (SQL Case Study)
-- =====================================================

-- 1. Create and Select Database
CREATE DATABASE spotify_analysis;
USE spotify_analysis;

-- 2. Preview Dataset
SELECT * 
FROM spotify_user_behavior_realistic_50000_rows 
LIMIT 5;

-- 3. Total Number of Records
SELECT COUNT(*) 
FROM spotify_user_behavior_realistic_50000_rows;

-- 4. View Table Structure
DESCRIBE spotify_user_behavior_realistic_50000_rows;

-- 5. Number of Unique Countries
SELECT COUNT(DISTINCT country) 
FROM spotify_user_behavior_realistic_50000_rows;

-- =====================================================
-- 📊 Subscription Analysis
-- =====================================================

-- 6. Distribution of Subscription Types
SELECT subscription_type, COUNT(*) AS users
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type;

-- 7. Which Subscription Type Listens the Most
SELECT subscription_type, 
       AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type
ORDER BY avg_hours DESC
LIMIT 1;

-- 8. Total Users by Subscription Type
SELECT subscription_type, COUNT(*) AS total_users
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type
ORDER BY total_users DESC;

-- 9. Avg Skips for Free vs Premium Individual Users
SELECT subscription_type,
       AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
WHERE subscription_type IN ('Free', 'Premium Individual')
GROUP BY subscription_type
ORDER BY avg_skips DESC;

-- 10. Avg Skips by User Type (Free vs All Premium)
SELECT 
    CASE 
        WHEN subscription_type = 'Free' THEN 'Free'
        ELSE 'Premium'
    END AS subscription_type_group,
    AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY subscription_type_group;

-- =====================================================
-- 📉 Inactivity Analysis
-- =====================================================

-- 11. Do Skips Affect Inactivity?
SELECT inactive_3_months_flag,
       AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

-- 12. Listening Hours vs Inactivity
SELECT inactive_3_months_flag,
       AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

-- 13. Playlists Created vs Inactivity
SELECT inactive_3_months_flag,
       AVG(playlists_created) AS avg_playlists
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

-- 14. Ad Interaction vs Inactivity
SELECT inactive_3_months_flag,
       AVG(ad_interaction = 'Yes') AS ad_interaction_rate
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

-- 15. Rating vs Inactivity
SELECT inactive_3_months_flag,
       AVG(music_suggestion_rating_1_to_5) AS avg_rating
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY inactive_3_months_flag;

-- =====================================================
-- 👥 Age-Based Analysis
-- =====================================================

-- 16. Age vs Engagement (Individual Ages)
SELECT age, 
       AVG(avg_listening_hours_per_week) AS avg_hours
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY age
ORDER BY avg_hours DESC;

-- 17. Age Group vs Engagement
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
ORDER BY avg_hours DESC;

-- =====================================================
-- 👤 Age vs Subscription Analysis
-- =====================================================

-- 18. Subscription Distribution by Age Group
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

-- 19. Top Subscription Type per Age Group (Using RANK)
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
        RANK() OVER (
            PARTITION BY 
                CASE 
                    WHEN age BETWEEN 18 AND 25 THEN '18-25'
                    WHEN age BETWEEN 26 AND 35 THEN '26-35'
                    WHEN age BETWEEN 36 AND 50 THEN '36-50'
                    ELSE '50+'
                END
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM spotify_user_behavior_realistic_50000_rows
    GROUP BY age_group, subscription_type
) t
WHERE rnk = 1;

-- =====================================================
-- 🎵 Genre Analysis
-- =====================================================

-- 20. Top Genres by Listening Hours and Skipping Behavior
SELECT favorite_genre,
       AVG(avg_listening_hours_per_week) AS avg_hours,
       AVG(avg_skips_per_day) AS avg_skips
FROM spotify_user_behavior_realistic_50000_rows
GROUP BY favorite_genre
ORDER BY avg_hours DESC;
