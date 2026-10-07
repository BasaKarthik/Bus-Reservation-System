USE bus_reservation_system;

-- ============================================
-- JOIN QUERIES
-- ============================================

-- 1. Bookings with passenger details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    b.fare,
    b.booking_status
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id;

-- 2. Bookings with schedule details
SELECT
    b.booking_id,
    s.schedule_id,
    s.departure_datetime,
    s.arrival_datetime,
    b.fare
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id;

-- 3. Bookings with passenger and schedule details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    s.departure_datetime,
    s.arrival_datetime,
    b.fare
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id;

-- 4. Bookings with route details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    r.source,
    r.destination,
    b.fare
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id;

-- 5. Bookings with bus details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    bus.bus_number,
    bus.bus_type,
    b.fare
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN buses bus
    ON s.bus_id = bus.bus_id;

-- 6. Complete booking details
SELECT
    b.booking_id,
    p.first_name,
    p.last_name,
    bus.bus_number,
    bus.bus_type,
    r.source,
    r.destination,
    st.seat_number,
    st.seat_type,
    b.fare,
    b.booking_status
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
INNER JOIN buses bus
    ON s.bus_id = bus.bus_id
INNER JOIN seats st
    ON b.seat_id = st.seat_id;

-- 7. Number of bookings per route
SELECT
    r.source,
    r.destination,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination
ORDER BY total_bookings DESC;

-- 8. Total booking value per route
SELECT
    r.source,
    r.destination,
    SUM(b.fare) AS total_booking_value
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination
ORDER BY total_booking_value DESC;

-- 9. Average fare per route
SELECT
    r.source,
    r.destination,
    AVG(b.fare) AS average_fare
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination
ORDER BY average_fare DESC;

-- 10. Routes with more than 2 bookings
SELECT
    r.source,
    r.destination,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination
HAVING COUNT(b.booking_id) > 2
ORDER BY total_bookings DESC;

-- 11. Routes with booking value greater than 2000
SELECT
    r.source,
    r.destination,
    SUM(b.fare) AS total_booking_value
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination
HAVING SUM(b.fare) > 2000
ORDER BY total_booking_value DESC;