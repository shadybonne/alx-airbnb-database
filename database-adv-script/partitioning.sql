
DROP TABLE IF EXISTS Booking;

CREATE TABLE Booking (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36),
    user_id CHAR(36),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date) * 100 + MONTH(start_date)) (
    PARTITION p202407 VALUES LESS THAN (202408),
    PARTITION p202408 VALUES LESS THAN (202409),
    PARTITION p202409 VALUES LESS THAN (202410),
    PARTITION p202410 VALUES LESS THAN (202411),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);


INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('b001-bkng-uuid-000000000001', 'p1a2b3c4-d5e6-7890-abcd-000000000001', 'a1b2c3d4-e5f6-7890-abcd-000000000004', '2025-07-10', '2025-07-15', 600.00, 'confirmed');


