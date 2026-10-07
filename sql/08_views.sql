USE bus_reservation_system;

-- 1. Detailed booking information
CREATE VIEW booking_details_view AS
SELECT
    b.booking_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    bus.bus_number,
    bus.bus_type,
    r.source,
    r.destination,
    s.departure_datetime,
    s.arrival_datetime,
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


-- 2. Confirmed bookings only
CREATE VIEW confirmed_bookings_view AS
SELECT
    booking_id,
    passenger_name,
    bus_number,
    bus_type,
    source,
    destination,
    departure_datetime,
    arrival_datetime,
    seat_number,
    seat_type,
    fare
FROM booking_details_view
WHERE booking_status = 'Confirmed';


-- 3. Route-wise booking summary
CREATE VIEW route_summary_view AS
SELECT
    r.source,
    r.destination,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.fare) AS total_booking_value,
    AVG(b.fare) AS average_fare
FROM bookings b
INNER JOIN schedules s
    ON b.schedule_id = s.schedule_id
INNER JOIN routes r
    ON s.route_id = r.route_id
GROUP BY
    r.source,
    r.destination;