# Index Performance

## Query

-- Before Indexing
EXPLAIN ANALYZE
SELECT * FROM users
WHERE email = 'lua@example.com';

-- Create Index
CREATE INDEX idx_users_email ON users(email);

-- After Indexing
EXPLAIN ANALYZE
SELECT * FROM users
WHERE email = 'lua@example.com';



-- User Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_start_end ON Booking(start_date, end_date);

-- Property Table Indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);


## indexes using EXPLAIN or ANALYZE.

EXPLAIN
SELECT 
    u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM User u
JOIN Booking b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id
ORDER BY total_bookings DESC;

