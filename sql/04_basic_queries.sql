USE bus_reservation_system;

-- ============================================
-- BASIC SQL QUERIES
-- ============================================

-- 1. Display all passengers
SELECT *
FROM passengers;

-- 2. Display selected passenger details
SELECT
    first_name,
    last_name,
    email
FROM passengers;

-- 3. Display unique genders
SELECT DISTINCT gender
FROM passengers;

-- 4. Sort passengers by age (ascending)
SELECT *
FROM passengers
ORDER BY age ASC;

-- 5. Sort passengers by age (descending)
SELECT *
FROM passengers
ORDER BY age DESC;

-- 6. Display the 5 oldest passengers
SELECT *
FROM passengers
ORDER BY age DESC
LIMIT 5;

-- 7. Passengers older than 30
SELECT *
FROM passengers
WHERE age > 30;

-- 8. Passengers aged 30 or above
SELECT *
FROM passengers
WHERE age >= 30;

-- 9. Female passengers older than 25
SELECT *
FROM passengers
WHERE gender = 'Female'
  AND age > 25;

-- 10. Female passengers OR passengers younger than 25
SELECT *
FROM passengers
WHERE gender = 'Female'
   OR age < 25;

-- 11. Passengers aged between 25 and 30
SELECT *
FROM passengers
WHERE age BETWEEN 25 AND 30;

-- 12. Passengers aged 23, 25, or 30
SELECT *
FROM passengers
WHERE age IN (23, 25, 30);

-- 13. Passengers whose first name starts with 'A'
SELECT *
FROM passengers
WHERE first_name LIKE 'A%';

-- 14. Passengers whose first name contains 'a'
SELECT *
FROM passengers
WHERE first_name LIKE '%a%';

-- 15. Passengers who are not female
SELECT *
FROM passengers
WHERE gender <> 'Female';

-- 16. Display confirmed bookings
SELECT *
FROM bookings
WHERE booking_status = 'Confirmed';

-- 17. Count confirmed bookings
SELECT COUNT(*) AS confirmed_bookings
FROM bookings
WHERE booking_status = 'Confirmed';

-- 18. Count bookings by status
SELECT
    booking_status,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY booking_status;

-- 19. Calculate total booking value
SELECT
    SUM(fare) AS total_booking_value
FROM bookings;

-- 20. Calculate average booking fare
SELECT
    AVG(fare) AS average_fare
FROM bookings;

-- 21. Find minimum and maximum fare
SELECT
    MIN(fare) AS minimum_fare,
    MAX(fare) AS maximum_fare
FROM bookings;

-- 22. Calculate overall booking statistics
SELECT
    COUNT(*) AS total_bookings,
    SUM(fare) AS total_booking_value,
    AVG(fare) AS average_fare,
    MIN(fare) AS minimum_fare,
    MAX(fare) AS maximum_fare
FROM bookings;

-- 23. Booking count and total value by status
SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    SUM(fare) AS total_booking_value
FROM bookings
GROUP BY booking_status;

-- 24. Booking count and average fare by status
SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    AVG(fare) AS average_fare
FROM bookings
GROUP BY booking_status
ORDER BY total_bookings DESC;