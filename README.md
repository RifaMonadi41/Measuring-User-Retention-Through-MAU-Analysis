# Measuring-User-Retention-Through-MAU-Analysis
This project analyzed user activity data to measure Monthly Active Users (MAU) and identify users who remained engaged across consecutive months. The goal was to understand user retention behavior by identifying individuals who performed platform actions in both the current and previous month.
📌 Problem
Facebook wants to measure user engagement by tracking Monthly Active Users (MAUs). Write a query to find the number of MAUs in July 2022.
An active user is defined as someone who performed at least one action (sign-in, like, or comment) in both the current month (July) and the previous month (June).
________________________________________
🗂️ Schema
user_actions
Column Name	Type
user_id	integer
event_id	integer
event_type	string ('sign-in', 'like', 'comment')
event_date	datetime
________________________________________
💡 Example
Input:
user_id	event_id	event_type	event_date
445	7765	sign-in	05/31/2022
742	6458	sign-in	06/03/2022
445	3634	like	06/05/2022
742	1374	comment	06/05/2022
648	3124	like	06/18/2022
Output (June 2022 example):
month	monthly_active_users
6	1
________________________________________
✅ Solution
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
________________________________________
🧠 Approach & Techniques
Step 1 — Isolate July active users A subquery filters all actions within July 2022 and returns the distinct user_ids who were active that month.
Step 2 — Isolate June active users A second subquery does the same for June 2022 — capturing users who were active the previous month.
Step 3 — Inner JOIN to find overlap Joining both subqueries on user_id keeps only users who appear in both months — the definition of a Monthly Active User. COUNT(DISTINCT) ensures each user is counted once even if they had multiple events.
Why this approach? Using two subqueries joined together is more readable and explicit than a single query with HAVING COUNT(DISTINCT month) = 2, making the retention logic immediately clear to any reader.
Key techniques used:
•	Subqueries as derived tables in FROM
•	INNER JOIN for set intersection (users active in both months)
•	COUNT(DISTINCT ...) to avoid duplicate counting
•	Date range filtering with >= and <=
________________________________________
📊 Business Insight
MAU tracking is one of the most critical product health metrics for any platform. This query identifies truly engaged users — those who return month over month — as opposed to one-time visitors, giving product teams a reliable signal of platform stickiness and retention performance.
________________________________________
Source: DataLemur · Active User Retention · Facebook - https://datalemur.com/questions/user-retention
