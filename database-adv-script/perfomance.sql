-- WHERE AND

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,

    -- User Info
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,

    -- Property Info
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,

    -- Payment Info
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date

FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

ORDER BY b.created_at DESC;

-- Performance Analysis
-- Use EXPLAIN ANALYZE to compare query performance
EXPLAIN ANALYZE SELECT * FROM bookings;
