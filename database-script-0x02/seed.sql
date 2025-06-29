-- Insert locations
INSERT INTO "locations" (country, state, city) VALUES
	('Nigeria', 'FCT', 'Abuja');

-- Insert users with different roles
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
    ('gift', 'john', 'gift.john@example.com', 'hashed_password_4', '+3111111111', 'admin'),
    ('musa', 'victor', 'musa.victor@example.com', 'hashed_password_5', '+8999999999', 'guest');
