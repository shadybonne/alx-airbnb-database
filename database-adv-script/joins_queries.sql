---sql

-- ORDER BY

-- LEFT JOIN: Retrieve all properties with their reviews (including properties without reviews)

SELECT 
    Booking.booking_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email
FROM Booking
INNER JOIN User ON Booking.user_id = User.user_id;

-- LEFT JOIN: Retrieve all properties with their reviews (including properties without reviews)

SELECT 
    Property.property_id,
    Property.name AS property_name,
    Property.location,
    Review.review_id,
    Review.rating,
    Review.comment
FROM Property
LEFT JOIN Review ON Property.property_id = Review.property_id;


-- Simulate FULL OUTER JOIN: all users and bookings, even unmatched


SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.start_date,
    Booking.status
FROM User
LEFT JOIN Booking ON User.user_id = Booking.user_id

UNION

SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.start_date,
    Booking.status
FROM Booking
RIGHT JOIN User ON User.user_id = Booking.user_id;

