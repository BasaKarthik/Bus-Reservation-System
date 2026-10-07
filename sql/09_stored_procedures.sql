USE bus_reservation_system;

-- 1. Search buses by source and destination
DELIMITER $$

CREATE PROCEDURE search_buses_by_route(
    IN p_source VARCHAR(100),
    IN p_destination VARCHAR(100)
)
BEGIN
    SELECT
        s.schedule_id,
        bus.bus_number,
        bus.bus_type,
        r.source,
        r.destination,
        s.departure_datetime,
        s.arrival_datetime
    FROM schedules s
    INNER JOIN buses bus
        ON s.bus_id = bus.bus_id
    INNER JOIN routes r
        ON s.route_id = r.route_id
    WHERE r.source = p_source
      AND r.destination = p_destination
    ORDER BY s.departure_datetime;
END $$

DELIMITER ;


-- 2. Get all bookings of a passenger
DELIMITER $$

CREATE PROCEDURE get_passenger_bookings(
    IN p_passenger_id INT
)
BEGIN
    SELECT
        b.booking_id,
        CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
        r.source,
        r.destination,
        s.departure_datetime,
        st.seat_number,
        b.fare,
        b.booking_status
    FROM bookings b
    INNER JOIN passengers p
        ON b.passenger_id = p.passenger_id
    INNER JOIN schedules s
        ON b.schedule_id = s.schedule_id
    INNER JOIN routes r
        ON s.route_id = r.route_id
    INNER JOIN seats st
        ON b.seat_id = st.seat_id
    WHERE b.passenger_id = p_passenger_id
    ORDER BY s.departure_datetime;
END $$

DELIMITER ;


-- 3. Get upcoming schedules for a route
DELIMITER $$

CREATE PROCEDURE get_available_schedules(
    IN p_source VARCHAR(100),
    IN p_destination VARCHAR(100)
)
BEGIN
    SELECT
        s.schedule_id,
        bus.bus_number,
        bus.bus_type,
        r.source,
        r.destination,
        s.departure_datetime,
        s.arrival_datetime
    FROM schedules s
    INNER JOIN buses bus
        ON s.bus_id = bus.bus_id
    INNER JOIN routes r
        ON s.route_id = r.route_id
    WHERE r.source = p_source
      AND r.destination = p_destination
      AND s.departure_datetime > NOW()
    ORDER BY s.departure_datetime;
END $$

DELIMITER ;