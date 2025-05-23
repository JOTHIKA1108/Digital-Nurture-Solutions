-- ===================================================================
-- ANSI SQL Exercises - MySQL
-- File: ansi_sql_exercises.sql
-- Contains all 25 queries for the given exercises with comments.
-- ===================================================================

-- Q1. User Upcoming Events
-- Show a list of all upcoming events a user is registered for in their city, sorted by date.

SELECT e.event_id, e.title, e.city, e.start_date, e.end_date
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
JOIN Events e ON r.event_id = e.event_id
WHERE u.user_id = ? -- replace with specific user_id
  AND e.status = 'upcoming'
  AND u.city = e.city
ORDER BY e.start_date;


-- Q2. Top Rated Events
-- Identify events with highest average rating with at least 10 feedbacks.

SELECT e.event_id, e.title, AVG(f.rating) AS avg_rating, COUNT(f.feedback_id) AS feedback_count
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY avg_rating DESC;


-- Q3. Inactive Users
-- Retrieve users who have not registered for any events in the last 90 days.

SELECT u.user_id, u.full_name, u.email
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id AND r.registration_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
WHERE r.registration_id IS NULL;


-- Q4. Peak Session Hours
-- Count sessions scheduled between 10 AM to 12 PM for each event.

SELECT event_id, COUNT(*) AS peak_sessions_count
FROM Sessions
WHERE TIME(start_time) >= '10:00:00' AND TIME(end_time) <= '12:00:00'
GROUP BY event_id;


-- Q5. Most Active Cities
-- Top 5 cities with highest number of distinct user registrations.

SELECT u.city, COUNT(DISTINCT r.user_id) AS active_users
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY active_users DESC
LIMIT 5;


-- Q6. Event Resource Summary
-- Number of resources by type for each event.

SELECT event_id, resource_type, COUNT(*) AS resource_count
FROM Resources
GROUP BY event_id, resource_type
ORDER BY event_id;


-- Q7. Low Feedback Alerts
-- Users who gave feedback with rating less than 3 along with comments and event names.

SELECT u.user_id, u.full_name, e.title AS event_title, f.rating, f.comments
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Events e ON f.event_id = e.event_id
WHERE f.rating < 3;


-- Q8. Sessions per Upcoming Event
-- Display upcoming events with count of sessions.

SELECT e.event_id, e.title, COUNT(s.session_id) AS sessions_count
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;


-- Q9. Organizer Event Summary
-- For each event organizer, show number of events and their current status counts.

SELECT u.user_id, u.full_name,
       SUM(CASE WHEN e.status = 'upcoming' THEN 1 ELSE 0 END) AS upcoming_events,
       SUM(CASE WHEN e.status = 'completed' THEN 1 ELSE 0 END) AS completed_events,
       SUM(CASE WHEN e.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_events,
       COUNT(e.event_id) AS total_events
FROM Users u
LEFT JOIN Events e ON u.user_id = e.organizer_id
GROUP BY u.user_id, u.full_name;


-- Q10. Feedback Gap
-- Events that had registrations but received no feedback.

SELECT e.event_id, e.title
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id, e.title;


-- Q11. Daily New User Count
-- Number of users registered each day in last 7 days.

SELECT registration_date, COUNT(*) AS new_users
FROM Users
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY registration_date
ORDER BY registration_date;


-- Q12. Event with Maximum Sessions
-- List event(s) with highest number of sessions.

WITH EventSessionCounts AS (
    SELECT event_id, COUNT(*) AS session_count
    FROM Sessions
    GROUP BY event_id
)
SELECT e.event_id, e.title, esc.session_count
FROM Events e
JOIN EventSessionCounts esc ON e.event_id = esc.event_id
WHERE esc.session_count = (SELECT MAX(session_count) FROM EventSessionCounts);


-- Q13. Average Rating per City
-- Average feedback rating of events conducted in each city.

SELECT e.city, AVG(f.rating) AS avg_rating
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.city;


-- Q14. Most Registered Events
-- Top 3 events based on total registrations.

SELECT e.event_id, e.title, COUNT(r.registration_id) AS total_registrations
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;


-- Q15. Event Session Time Conflict
-- Identify overlapping sessions within the same event.

SELECT s1.event_id, s1.session_id AS session1_id, s2.session_id AS session2_id
FROM Sessions s1
JOIN Sessions s2 ON s1.event_id = s2.event_id
  AND s1.session_id <> s2.session_id
  AND s1.start_time < s2.end_time
  AND s2.start_time < s1.end_time
ORDER BY s1.event_id, s1.session_id, s2.session_id;


-- Q16. Unregistered Active Users
-- Users created account in last 30 days but not registered for any events.

SELECT u.user_id, u.full_name, u.registration_date
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
WHERE u.registration_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
  AND r.registration_id IS NULL;


-- Q17. Multi-Session Speakers
-- Speakers handling more than one session.

SELECT speaker_name, COUNT(*) AS session_count
FROM Sessions
GROUP BY speaker_name
HAVING session_count > 1;


-- Q18. Resource Availability Check
-- Events with no resources uploaded.

SELECT e.event_id, e.title
FROM Events e
LEFT JOIN Resources r ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- Q19. Completed Events with Feedback Summary
-- For completed events, show total registrations and average feedback rating.

SELECT e.event_id, e.title,
       COUNT(DISTINCT r.registration_id) AS total_registrations,
       AVG(f.rating) AS avg_rating
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;


-- Q20. User Engagement Index
-- For each user, count of events attended and feedbacks submitted.

SELECT u.user_id, u.full_name,
       COUNT(DISTINCT r.event_id) AS events_attended,
       COUNT(DISTINCT f.feedback_id) AS feedback_submitted
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
LEFT JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name;


-- Q21. Top Feedback Providers
-- Top 5 users who submitted most feedback entries.

SELECT u.user_id, u.full_name, COUNT(f.feedback_id) AS feedback_count
FROM Users u
JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY feedback_count DESC
LIMIT 5;


-- Q22. Duplicate Registrations Check
-- Detect users registered more than once for same event.

SELECT user_id, event_id, COUNT(*) AS registration_count
FROM Registrations
GROUP BY user_id, event_id
HAVING registration_count > 1;


-- Q23. Registration Trends
-- Month-wise registration count for past 12 months.

SELECT DATE_FORMAT(registration_date, '%Y-%m') AS reg_month, COUNT(*) AS registrations
FROM Registrations
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY reg_month
ORDER BY reg_month;


-- Q24. Average Session Duration per Event
-- Average duration in minutes of sessions per event.

SELECT event_id,
       AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS avg_session_duration_min
FROM Sessions
GROUP BY event_id;


-- Q25. Events Without Sessions
-- List events with no sessions scheduled.

SELECT e.event_id, e.title
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE s.session_id IS NULL;