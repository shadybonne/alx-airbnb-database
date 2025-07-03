
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    AVG(r.rating) AS avg_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location
HAVING AVG(r.rating) > 4.0;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE (
    SELECT COUNT(*) 
    FROM Booking b 
    WHERE b.user_id = u.user_id
) > 3;

