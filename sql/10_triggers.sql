USE bus_reservation_system;

-- Automatically mark payment as refunded
-- when a booking is cancelled

DELIMITER $$

CREATE TRIGGER after_booking_cancelled
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    IF NEW.booking_status = 'Cancelled'
       AND OLD.booking_status <> 'Cancelled' THEN

        UPDATE payments
        SET payment_status = 'Refunded'
        WHERE booking_id = NEW.booking_id;

    END IF;
END $$

DELIMITER ;