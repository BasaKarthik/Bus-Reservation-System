USE bus_reservation_system;

-- ============================================
-- PASSENGERS
-- ============================================

INSERT INTO passengers
(first_name, last_name, gender, age, phone, email)
VALUES
('Rahul', 'Kumar', 'Male', 28, '9876543210', 'rahul.kumar@gmail.com'),
('Priya', 'Sharma', 'Female', 25, '9876543211', 'priya.sharma@gmail.com'),
('Arjun', 'Reddy', 'Male', 32, '9876543212', 'arjun.reddy@gmail.com'),
('Sneha', 'Patel', 'Female', 29, '9876543213', 'sneha.patel@gmail.com'),
('Karthik', 'Rao', 'Male', 24, '9876543214', 'karthik.rao@gmail.com'),
('Anjali', 'Verma', 'Female', 31, '9876543215', 'anjali.verma@gmail.com'),
('Vikram', 'Singh', 'Male', 35, '9876543216', 'vikram.singh@gmail.com'),
('Divya', 'Reddy', 'Female', 27, '9876543217', 'divya.reddy@gmail.com'),
('Rohit', 'Mehta', 'Male', 30, '9876543218', 'rohit.mehta@gmail.com'),
('Pooja', 'Nair', 'Female', 26, '9876543219', 'pooja.nair@gmail.com'),
('Sandeep', 'Kumar', 'Male', 38, '9876543220', 'sandeep.kumar@gmail.com'),
('Neha', 'Gupta', 'Female', 23, '9876543221', 'neha.gupta@gmail.com'),
('Manoj', 'Yadav', 'Male', 41, '9876543222', 'manoj.yadav@gmail.com'),
('Swathi', 'Rao', 'Female', 34, '9876543223', 'swathi.rao@gmail.com'),
('Aditya', 'Shah', 'Male', 29, '9876543224', 'aditya.shah@gmail.com');

-- ============================================
-- BUSES
-- ============================================

INSERT INTO buses
(bus_number, bus_type, total_seats, operator)
VALUES
('TS09AB1234', 'AC Sleeper', 36, 'TSRTC'),
('TS10CD5678', 'AC Seater', 40, 'TSRTC'),
('AP16EF9012', 'Volvo AC', 45, 'Orange Travels'),
('KA05GH3456', 'AC Sleeper', 36, 'VRL Travels'),
('TS11IJ7890', 'Non-AC Seater', 52, 'TSRTC'),
('AP09KL2345', 'AC Seater', 40, 'Morning Star Travels'),
('KA01MN6789', 'Volvo AC', 45, 'SRS Travels'),
('TS12OP4567', 'Non-AC Seater', 52, 'TSRTC');

-- ============================================
-- ROUTES
-- ============================================

INSERT INTO routes
(source, destination, distance_km)
VALUES
('Hyderabad', 'Vijayawada', 275.50),
('Hyderabad', 'Warangal', 150.00),
('Hyderabad', 'Bengaluru', 570.00),
('Hyderabad', 'Tirupati', 560.00),
('Hyderabad', 'Visakhapatnam', 620.00),
('Hyderabad', 'Chennai', 625.00),
('Hyderabad', 'Mumbai', 710.00),
('Hyderabad', 'Pune', 560.00);

-- ============================================
-- SCHEDULES
-- ============================================

INSERT INTO schedules
(bus_id, route_id, departure_datetime, arrival_datetime)
VALUES
(1, 1, '2026-10-10 06:00:00', '2026-10-10 12:00:00'),
(2, 2, '2026-10-10 07:30:00', '2026-10-10 11:00:00'),
(3, 3, '2026-10-10 20:00:00', '2026-10-11 07:00:00'),
(4, 4, '2026-10-11 19:00:00', '2026-10-12 06:00:00'),
(5, 5, '2026-10-11 05:30:00', '2026-10-11 17:30:00'),
(6, 6, '2026-10-11 18:00:00', '2026-10-12 06:00:00'),
(7, 7, '2026-10-12 17:00:00', '2026-10-13 08:00:00'),
(8, 8, '2026-10-12 21:00:00', '2026-10-13 07:00:00'),
(1, 2, '2026-10-13 08:00:00', '2026-10-13 11:30:00'),
(2, 1, '2026-10-13 09:00:00', '2026-10-13 15:00:00'),
(3, 5, '2026-10-14 19:30:00', '2026-10-15 07:30:00'),
(4, 3, '2026-10-14 20:30:00', '2026-10-15 08:00:00');

-- ============================================
-- SEATS
-- ============================================

-- Seats for Bus 1
INSERT INTO seats (bus_id, seat_number, seat_type)
WITH RECURSIVE seat_numbers AS (
    SELECT 1 AS seat_no
    UNION ALL
    SELECT seat_no + 1
    FROM seat_numbers
    WHERE seat_no < 36
)
SELECT
    1,
    CONCAT('S', seat_no),
    CASE
        WHEN seat_no <= 18 THEN 'Window'
        ELSE 'Aisle'
    END
FROM seat_numbers;


-- Seats for Buses 2 to 8
INSERT INTO seats (bus_id, seat_number, seat_type)
WITH RECURSIVE seat_numbers AS (
    SELECT 1 AS seat_no
    UNION ALL
    SELECT seat_no + 1
    FROM seat_numbers
    WHERE seat_no < 52
)
SELECT
    b.bus_id,
    CONCAT('S', seat_no),
    CASE
        WHEN seat_no <= CEIL(b.total_seats / 2) THEN 'Window'
        ELSE 'Aisle'
    END
FROM buses b
JOIN seat_numbers
    ON seat_numbers.seat_no <= b.total_seats
WHERE b.bus_id BETWEEN 2 AND 8;

-- ============================================
-- BOOKINGS
-- ============================================

INSERT INTO bookings
(passenger_id, schedule_id, seat_id, booking_date, fare, booking_status)
VALUES
(1, 1, (SELECT seat_id FROM seats WHERE bus_id = 1 AND seat_number = 'S1'), '2026-10-06 09:15:00', 450.00, 'Confirmed'),
(2, 1, (SELECT seat_id FROM seats WHERE bus_id = 1 AND seat_number = 'S2'), '2026-10-06 09:30:00', 450.00, 'Confirmed'),
(3, 2, (SELECT seat_id FROM seats WHERE bus_id = 2 AND seat_number = 'S1'), '2026-10-06 09:45:00', 300.00, 'Confirmed'),
(4, 2, (SELECT seat_id FROM seats WHERE bus_id = 2 AND seat_number = 'S2'), '2026-10-06 10:00:00', 300.00, 'Confirmed'),
(5, 3, (SELECT seat_id FROM seats WHERE bus_id = 3 AND seat_number = 'S1'), '2026-10-06 10:15:00', 900.00, 'Confirmed'),
(6, 3, (SELECT seat_id FROM seats WHERE bus_id = 3 AND seat_number = 'S2'), '2026-10-06 10:30:00', 900.00, 'Confirmed'),
(7, 4, (SELECT seat_id FROM seats WHERE bus_id = 4 AND seat_number = 'S1'), '2026-10-06 10:45:00', 850.00, 'Confirmed'),
(8, 4, (SELECT seat_id FROM seats WHERE bus_id = 4 AND seat_number = 'S2'), '2026-10-06 11:00:00', 850.00, 'Confirmed'),
(9, 5, (SELECT seat_id FROM seats WHERE bus_id = 5 AND seat_number = 'S1'), '2026-10-06 11:15:00', 1000.00, 'Confirmed'),
(10, 5, (SELECT seat_id FROM seats WHERE bus_id = 5 AND seat_number = 'S2'), '2026-10-06 11:30:00', 1000.00, 'Confirmed'),
(11, 6, (SELECT seat_id FROM seats WHERE bus_id = 6 AND seat_number = 'S1'), '2026-10-06 11:45:00', 950.00, 'Confirmed'),
(12, 6, (SELECT seat_id FROM seats WHERE bus_id = 6 AND seat_number = 'S2'), '2026-10-06 12:00:00', 950.00, 'Confirmed'),
(13, 7, (SELECT seat_id FROM seats WHERE bus_id = 7 AND seat_number = 'S1'), '2026-10-06 12:15:00', 1200.00, 'Confirmed'),
(14, 7, (SELECT seat_id FROM seats WHERE bus_id = 7 AND seat_number = 'S2'), '2026-10-06 12:30:00', 1200.00, 'Pending'),
(15, 8, (SELECT seat_id FROM seats WHERE bus_id = 8 AND seat_number = 'S1'), '2026-10-06 12:45:00', 1100.00, 'Confirmed'),
(1, 8, (SELECT seat_id FROM seats WHERE bus_id = 8 AND seat_number = 'S2'), '2026-10-06 13:00:00', 1100.00, 'Confirmed'),
(2, 9, (SELECT seat_id FROM seats WHERE bus_id = 1 AND seat_number = 'S3'), '2026-10-06 13:15:00', 300.00, 'Confirmed'),
(3, 10, (SELECT seat_id FROM seats WHERE bus_id = 2 AND seat_number = 'S3'), '2026-10-06 13:30:00', 450.00, 'Confirmed'),
(4, 11, (SELECT seat_id FROM seats WHERE bus_id = 3 AND seat_number = 'S3'), '2026-10-06 13:45:00', 1000.00, 'Cancelled'),
(5, 12, (SELECT seat_id FROM seats WHERE bus_id = 4 AND seat_number = 'S3'), '2026-10-06 14:45:00', 900.00, 'Confirmed');

-- ============================================
-- PAYMENTS
-- ============================================

INSERT INTO payments
(booking_id, amount, payment_method, payment_status, payment_date)
VALUES
(1, 450.00, 'UPI', 'Paid', '2026-10-06 09:20:00'),
(2, 450.00, 'Credit Card', 'Paid', '2026-10-06 09:35:00'),
(3, 300.00, 'UPI', 'Paid', '2026-10-06 09:50:00'),
(4, 300.00, 'Debit Card', 'Paid', '2026-10-06 10:05:00'),
(5, 900.00, 'UPI', 'Paid', '2026-10-06 10:20:00'),
(6, 900.00, 'Credit Card', 'Paid', '2026-10-06 10:35:00'),
(7, 850.00, 'UPI', 'Paid', '2026-10-06 10:50:00'),
(8, 850.00, 'Debit Card', 'Paid', '2026-10-06 11:05:00'),
(9, 1000.00, 'UPI', 'Paid', '2026-10-06 11:20:00'),
(10, 1000.00, 'Credit Card', 'Paid', '2026-10-06 11:35:00'),
(11, 950.00, 'UPI', 'Paid', '2026-10-06 11:50:00'),
(12, 950.00, 'Debit Card', 'Paid', '2026-10-06 12:05:00'),
(13, 1200.00, 'UPI', 'Paid', '2026-10-06 12:20:00'),
(14, 1200.00, 'UPI', 'Pending', '2026-10-06 12:35:00'),
(15, 1100.00, 'Credit Card', 'Paid', '2026-10-06 12:50:00'),
(16, 1100.00, 'UPI', 'Paid', '2026-10-06 13:05:00'),
(17, 300.00, 'Debit Card', 'Paid', '2026-10-06 13:20:00'),
(18, 450.00, 'UPI', 'Paid', '2026-10-06 13:35:00'),
(19, 1000.00, 'Credit Card', 'Refunded', '2026-10-06 14:00:00'),
(20, 900.00, 'UPI', 'Paid', '2026-10-06 14:50:00');

-- ============================================
-- CANCELLATIONS
-- ============================================

INSERT INTO cancellations
(booking_id, cancellation_date, refund_amount, reason)
VALUES
(19, '2026-10-06 15:00:00', 1000.00, 'Passenger cancelled the booking');