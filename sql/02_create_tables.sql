USE bus_reservation_system;

CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    age INT,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_number VARCHAR(20) NOT NULL UNIQUE,
    bus_type VARCHAR(30) NOT NULL,
    total_seats INT NOT NULL,
    operator VARCHAR(100) NOT NULL
);

CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    distance_km DECIMAL(6,2) NOT NULL
);

CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    departure_datetime DATETIME NOT NULL,
    arrival_datetime DATETIME NOT NULL,

    FOREIGN KEY (bus_id)
        REFERENCES buses(bus_id),

    FOREIGN KEY (route_id)
        REFERENCES routes(route_id)
);

CREATE TABLE seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type VARCHAR(20) NOT NULL,

    FOREIGN KEY (bus_id)
        REFERENCES buses(bus_id),

    UNIQUE (bus_id, seat_number)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    schedule_id INT NOT NULL,
    seat_id INT NOT NULL,
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fare DECIMAL(10,2) NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',

    FOREIGN KEY (passenger_id)
        REFERENCES passengers(passenger_id),

    FOREIGN KEY (schedule_id)
        REFERENCES schedules(schedule_id),

    FOREIGN KEY (seat_id)
        REFERENCES seats(seat_id),

    UNIQUE (schedule_id, seat_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Paid',
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id),

    UNIQUE (booking_id)
);

CREATE TABLE cancellations (
    cancellation_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    cancellation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    refund_amount DECIMAL(10,2) NOT NULL,
    reason VARCHAR(255),

    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id),

    UNIQUE (booking_id)
);