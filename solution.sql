SELECT 
  7 AS month,
  COUNT(DISTINCT july.user_id) AS monthly_active_users
FROM (
  SELECT DISTINCT user_id 
  FROM user_actions
  WHERE event_date >= '07/01/2022' 
    AND event_date <= '07/31/2022'
) AS july
JOIN (
  SELECT DISTINCT user_id 
  FROM user_actions
  WHERE event_date >= '06/01/2022' 
    AND event_date <= '06/30/2022'
) AS june
ON june.user_id = july.user_id;
