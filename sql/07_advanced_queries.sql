USE bus_reservation_system;

-- ============================================
-- ADVANCED SQL QUERIES
-- ============================================

-- 1. Categorize bookings by fare
SELECT
    booking_id,
    fare,
    booking_status,
    CASE
        WHEN fare >= 1000 THEN 'High Fare'
        WHEN fare >= 700 THEN 'Medium Fare'
        ELSE 'Low Fare'
    END AS fare_category
FROM bookings
ORDER BY fare DESC;


-- 2. Fare category summary
SELECT
    CASE
        WHEN fare >= 1000 THEN 'High Fare'
        WHEN fare >= 700 THEN 'Medium Fare'
        ELSE 'Low Fare'
    END AS fare_category,
    COUNT(*) AS total_bookings,
    SUM(fare) AS total_booking_value,
    AVG(fare) AS average_fare
FROM bookings
GROUP BY
    CASE
        WHEN fare >= 1000 THEN 'High Fare'
        WHEN fare >= 700 THEN 'Medium Fare'
        ELSE 'Low Fare'
    END
ORDER BY total_booking_value DESC;


-- 3. Route booking summary using CTE
WITH route_bookings AS (
    SELECT
        s.route_id,
        COUNT(b.booking_id) AS total_bookings
    FROM bookings b
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    GROUP BY s.route_id
)
SELECT *
FROM route_bookings;


-- 4. CTE with route names
WITH route_bookings AS (
    SELECT
        s.route_id,
        COUNT(b.booking_id) AS total_bookings
    FROM bookings b
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    GROUP BY s.route_id
)
SELECT
    r.source,
    r.destination,
    rb.total_bookings
FROM route_bookings rb
INNER JOIN routes r
    ON rb.route_id = r.route_id
ORDER BY rb.total_bookings DESC;


-- 5. Routes with more than 2 bookings using CTE
WITH route_bookings AS (
    SELECT
        s.route_id,
        COUNT(b.booking_id) AS total_bookings
    FROM bookings b
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    GROUP BY s.route_id
)
SELECT
    r.source,
    r.destination,
    rb.total_bookings
FROM route_bookings rb
INNER JOIN routes r
    ON rb.route_id = r.route_id
WHERE rb.total_bookings > 2
ORDER BY rb.total_bookings DESC;


-- 6. Routes with the highest booking count
WITH route_bookings AS (
    SELECT
        s.route_id,
        COUNT(b.booking_id) AS total_bookings
    FROM bookings b
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    GROUP BY s.route_id
)
SELECT
    r.source,
    r.destination,
    rb.total_bookings
FROM route_bookings rb
INNER JOIN routes r
    ON rb.route_id = r.route_id
WHERE rb.total_bookings = (
    SELECT MAX(total_bookings)
    FROM route_bookings
);


-- 7. ROW_NUMBER ranking by fare
SELECT
    booking_id,
    passenger_id,
    fare,
    ROW_NUMBER() OVER (
        ORDER BY fare DESC
    ) AS fare_rank
FROM bookings;


-- 8. RANK ranking by fare
SELECT
    booking_id,
    passenger_id,
    fare,
    RANK() OVER (
        ORDER BY fare DESC
    ) AS fare_rank
FROM bookings;


-- 9. DENSE_RANK ranking by fare
SELECT
    booking_id,
    passenger_id,
    fare,
    DENSE_RANK() OVER (
        ORDER BY fare DESC
    ) AS fare_rank
FROM bookings;


-- 10. Top 3 fare levels using DENSE_RANK
WITH ranked_bookings AS (
    SELECT
        booking_id,
        passenger_id,
        fare,
        DENSE_RANK() OVER (
            ORDER BY fare DESC
        ) AS fare_rank
    FROM bookings
)
SELECT
    booking_id,
    passenger_id,
    fare,
    fare_rank
FROM ranked_bookings
WHERE fare_rank <= 3
ORDER BY fare DESC;


-- 11. Rank bookings within each route
SELECT
    b.booking_id,
    r.source,
    r.destination,
    b.fare,
    ROW_NUMBER() OVER (
        PARTITION BY s.route_id
        ORDER BY b.fare DESC
    ) AS route_fare_rank
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
ORDER BY
    r.route_id,
    route_fare_rank;


-- 12. Highest-fare booking per route
WITH ranked_bookings AS (
    SELECT
        b.booking_id,
        p.first_name,
        p.last_name,
        r.source,
        r.destination,
        b.fare,
        ROW_NUMBER() OVER (
            PARTITION BY s.route_id
            ORDER BY b.fare DESC
        ) AS route_fare_rank
    FROM bookings b
    INNER JOIN passengers p
        ON b.passenger_id = p.passenger_id
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    INNER JOIN routes r
        ON s.route_id = r.route_id
)
SELECT
    booking_id,
    first_name,
    last_name,
    source,
    destination,
    fare
FROM ranked_bookings
WHERE route_fare_rank = 1
ORDER BY fare DESC;


-- 13. All tied highest-fare bookings per route
WITH ranked_bookings AS (
    SELECT
        b.booking_id,
        p.first_name,
        p.last_name,
        r.source,
        r.destination,
        b.fare,
        RANK() OVER (
            PARTITION BY s.route_id
            ORDER BY b.fare DESC
        ) AS route_fare_rank
    FROM bookings b
    INNER JOIN passengers p
        ON b.passenger_id = p.passenger_id
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    INNER JOIN routes r
        ON s.route_id = r.route_id
)
SELECT
    booking_id,
    first_name,
    last_name,
    source,
    destination,
    fare
FROM ranked_bookings
WHERE route_fare_rank = 1
ORDER BY fare DESC;


-- 14. Extract booking date and time
SELECT
    booking_id,
    booking_date,
    DATE(booking_date) AS booking_only_date,
    TIME(booking_date) AS booking_only_time
FROM bookings
ORDER BY booking_id;


-- 15. Extract booking year and month
SELECT
    booking_id,
    booking_date,
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month
FROM bookings
ORDER BY booking_id;


-- 16. Days between booking and departure
SELECT
    b.booking_id,
    DATE(b.booking_date) AS booking_date,
    DATE(s.departure_datetime) AS departure_date,
    DATEDIFF(
        DATE(s.departure_datetime),
        DATE(b.booking_date)
    ) AS days_before_departure
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
ORDER BY b.booking_id;


-- 17. Hours between booking and departure
SELECT
    b.booking_id,
    b.booking_date,
    s.departure_datetime,
    TIMESTAMPDIFF(
        HOUR,
        b.booking_date,
        s.departure_datetime
    ) AS hours_before_departure
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
ORDER BY b.booking_id;


-- 18. Calculate journey duration
SELECT
    schedule_id,
    departure_datetime,
    arrival_datetime,
    TIMESTAMPDIFF(
        HOUR,
        departure_datetime,
        arrival_datetime
    ) AS journey_hours
FROM schedules
ORDER BY schedule_id;