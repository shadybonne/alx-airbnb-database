-- Users Table
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_host BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_users_email ON Users(email);

-- Property Types Table
CREATE TABLE Property_Types (
    property_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Listings Table
CREATE TABLE Listings (
    listing_id SERIAL PRIMARY KEY,
    host_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zipcode VARCHAR(20),
    price_per_night DECIMAL(10, 2) NOT NULL,
    max_guests INTEGER NOT NULL,
    property_type_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (property_type_id) REFERENCES Property_Types(property_type_id) ON DELETE SET NULL
);

CREATE INDEX idx_listings_city ON Listings(city);
CREATE INDEX idx_listings_price ON Listings(price_per_night);

-- Bookings Table
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    guest_id INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'confirmed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES Listings(listing_id) ON DELETE CASCADE,
    CHECK (check_out > check_in)
);

CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_listing_id ON Bookings(listing_id);

-- Reviews Table
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    reviewer_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_reviews_rating ON Reviews(rating);

-- Payments Table
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(20) DEFAULT 'completed',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

CREATE INDEX idx_payments_booking_id ON Payments(booking_id);

-- Amenities Table
CREATE TABLE Amenities (
    amenity_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Listing_Amenities Join Table
CREATE TABLE Listing_Amenities (
    listing_id INTEGER NOT NULL,
    amenity_id INTEGER NOT NULL,
    PRIMARY KEY (listing_id, amenity_id),
    FOREIGN KEY (listing_id) REFERENCES Listings(listing_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES Amenities(amenity_id) ON DELETE CASCADE
);

CREATE INDEX idx_listing_amenities_listing_id ON Listing_Amenities(listing_id);

-- Messages Table
CREATE TABLE Messages (
    message_id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    listing_id INTEGER,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES Listings(listing_id) ON DELETE SET NULL
);

CREATE INDEX idx_messages_sender_id ON Messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON Messages(receiver_id);
CREATE INDEX idx_messages_listing_id ON Messages(listing_id);

