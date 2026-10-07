USE bus_reservation_system;

-- ============================================
-- BUSINESS ANALYSIS QUERIES
-- ============================================

-- 1. Passenger-wise booking count
SELECT
    p.first_name,
    p.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM passengers p
INNER JOIN bookings b
    ON p.passenger_id = b.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name
ORDER BY total_bookings DESC;


-- 2. Passenger-wise total booking value
SELECT
    p.first_name,
    p.last_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.fare) AS total_booking_value
FROM passengers p
INNER JOIN bookings b
    ON p.passenger_id = b.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name
ORDER BY total_booking_value DESC;


-- 3. Bus-wise booking count
SELECT
    bus.bus_number,
    bus.bus_type,
    COUNT(b.booking_id) AS total_bookings
FROM buses bus
INNER JOIN schedules s
    ON bus.bus_id = s.bus_id
INNER JOIN bookings b
    ON s.schedule_id = b.schedule_id
GROUP BY
    bus.bus_id,
    bus.bus_number,
    bus.bus_type
ORDER BY total_bookings DESC;


-- 4. Operator-wise booking analysis
SELECT
    bus.operator,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.fare) AS total_booking_value
FROM buses bus
INNER JOIN schedules s
    ON bus.bus_id = s.bus_id
INNER JOIN bookings b
    ON s.schedule_id = b.schedule_id
GROUP BY bus.operator
ORDER BY total_booking_value DESC;


-- 5. Confirmed bookings by route
SELECT
    r.source,
    r.destination,
    COUNT(b.booking_id) AS confirmed_bookings
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
WHERE b.booking_status = 'Confirmed'
GROUP BY
    r.source,
    r.destination
ORDER BY confirmed_bookings DESC;


-- 6. Pending bookings
SELECT
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    r.source,
    r.destination,
    b.fare,
    b.booking_status
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
WHERE b.booking_status = 'Pending';


-- 7. Cancellation report
SELECT
    c.cancellation_id,
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    r.source,
    r.destination,
    b.fare,
    c.refund_amount,
    c.reason
FROM cancellations c
INNER JOIN bookings b
    ON c.booking_id = b.booking_id
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id;


-- 8. Actual paid revenue
SELECT
    SUM(amount) AS actual_paid_revenue
FROM payments
WHERE payment_status = 'Paid';


-- 9. Revenue by payment method
SELECT
    payment_method,
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_amount DESC;


-- 10. Payment status summary
SELECT
    payment_status,
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;


-- 11. Destination-wise booking count
SELECT
    r.destination,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY r.destination
ORDER BY total_bookings DESC;


-- 12. Top 5 highest-value bookings
SELECT
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    r.destination,
    b.fare,
    b.booking_status
FROM bookings b
INNER JOIN passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
ORDER BY b.fare DESC
LIMIT 5;


-- 13. Upcoming schedules
SELECT
    s.schedule_id,
    bus.bus_number,
    r.source,
    r.destination,
    s.departure_datetime,
    s.arrival_datetime
FROM schedules s
INNER JOIN buses bus
    ON s.bus_id = bus.bus_id
INNER JOIN routes r
    ON s.route_id = r.route_id
WHERE s.departure_datetime > NOW()
ORDER BY s.departure_datetime;


-- 14. Booking status summary
SELECT
    booking_status,
    COUNT(booking_id) AS total_bookings,
    SUM(fare) AS total_booking_value,
    AVG(fare) AS average_fare
FROM bookings
GROUP BY booking_status
ORDER BY total_bookings DESC;