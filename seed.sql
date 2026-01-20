-- ===============================================
-- BARBERSHOP DNA - SEED DATA FOR TESTING
-- File: seed.sql
-- Date: 2026-01-20
-- Description: Sample data for development & testing
-- ===============================================

-- ===== SAMPLE USERS (CUSTOMERS) =====
INSERT OR IGNORE INTO users (id, email, phone, password_hash, full_name, loyalty_tier, loyalty_points, referral_code) VALUES
  ('user1', 'alice@example.com', '+6281234567801', '$2b$10$dummy_hash_alice', 'Alice Johnson', 'gold', 250, 'ALICE123'),
  ('user2', 'bob@example.com', '+6281234567802', '$2b$10$dummy_hash_bob', 'Bob Smith', 'silver', 150, 'BOB456'),
  ('user3', 'charlie@example.com', '+6281234567803', '$2b$10$dummy_hash_charlie', 'Charlie Brown', 'bronze', 50, 'CHARLIE7');

-- ===== SAMPLE BARBERS =====
INSERT OR IGNORE INTO barbers (
  id, email, phone, password_hash, full_name, bio, years_experience, 
  specialties, barbershop_name, address, latitude, longitude, 
  subscription_tier, average_rating, total_reviews, is_verified
) VALUES
  (
    'barber1', 
    'rizky@barbershop.com', 
    '+6281234560001', 
    '$2b$10$dummy_hash_rizky',
    'Rizky Pratama',
    'Expert in modern fades and beard styling. 10+ years experience.',
    10,
    '["fades", "beard", "classic"]',
    'Rizky Barber House',
    'Jl. Sudirman No. 123, Jakarta Selatan',
    -6.2088,
    106.8456,
    'pro',
    4.8,
    120,
    TRUE
  ),
  (
    'barber2',
    'andi@barbershop.com',
    '+6281234560002',
    '$2b$10$dummy_hash_andi',
    'Andi Kurniawan',
    'Specialist in trendy hairstyles and hair coloring.',
    7,
    '["trendy", "coloring", "fades"]',
    'Andi Modern Cuts',
    'Jl. Gatot Subroto No. 45, Jakarta Pusat',
    -6.2115,
    106.8294,
    'starter',
    4.6,
    85,
    TRUE
  ),
  (
    'barber3',
    'dedi@barbershop.com',
    '+6281234560003',
    '$2b$10$dummy_hash_dedi',
    'Dedi Santoso',
    'Classic barbershop experience with premium service.',
    15,
    '["classic", "premium", "shave"]',
    'Dedi Classic Barber',
    'Jl. Thamrin No. 78, Jakarta Pusat',
    -6.1944,
    106.8229,
    'enterprise',
    4.9,
    200,
    TRUE
  );

-- ===== SAMPLE SERVICES =====
INSERT OR IGNORE INTO services (id, barber_id, name, description, duration_minutes, price) VALUES
  -- Rizky's services
  ('service1', 'barber1', 'Haircut Premium', 'Premium haircut with wash and styling', 45, 50000),
  ('service2', 'barber1', 'Beard Trim', 'Professional beard trimming and shaping', 20, 25000),
  ('service3', 'barber1', 'Haircut + Beard', 'Complete grooming package', 60, 70000),
  -- Andi's services
  ('service4', 'barber2', 'Trendy Haircut', 'Modern trendy hairstyles', 40, 45000),
  ('service5', 'barber2', 'Hair Coloring', 'Professional hair coloring service', 90, 150000),
  ('service6', 'barber2', 'Fade Cut', 'Clean fade haircut', 35, 40000),
  -- Dedi's services
  ('service7', 'barber3', 'Classic Cut', 'Traditional barbershop experience', 50, 60000),
  ('service8', 'barber3', 'Hot Towel Shave', 'Luxury hot towel shaving', 30, 50000),
  ('service9', 'barber3', 'Deluxe Package', 'Haircut + Beard + Shave', 90, 120000);

-- ===== SAMPLE AVAILABILITY (Working Hours) =====
-- Rizky's schedule (Monday-Saturday, 9 AM - 6 PM)
INSERT OR IGNORE INTO availability (barber_id, day_of_week, start_time, end_time) VALUES
  ('barber1', 1, '09:00', '18:00'), -- Monday
  ('barber1', 2, '09:00', '18:00'), -- Tuesday
  ('barber1', 3, '09:00', '18:00'), -- Wednesday
  ('barber1', 4, '09:00', '18:00'), -- Thursday
  ('barber1', 5, '09:00', '18:00'), -- Friday
  ('barber1', 6, '09:00', '16:00'); -- Saturday

-- Andi's schedule (Monday-Saturday, 10 AM - 7 PM)
INSERT OR IGNORE INTO availability (barber_id, day_of_week, start_time, end_time) VALUES
  ('barber2', 1, '10:00', '19:00'),
  ('barber2', 2, '10:00', '19:00'),
  ('barber2', 3, '10:00', '19:00'),
  ('barber2', 4, '10:00', '19:00'),
  ('barber2', 5, '10:00', '19:00'),
  ('barber2', 6, '10:00', '17:00');

-- Dedi's schedule (Tuesday-Sunday, 11 AM - 8 PM)
INSERT OR IGNORE INTO availability (barber_id, day_of_week, start_time, end_time) VALUES
  ('barber3', 2, '11:00', '20:00'),
  ('barber3', 3, '11:00', '20:00'),
  ('barber3', 4, '11:00', '20:00'),
  ('barber3', 5, '11:00', '20:00'),
  ('barber3', 6, '11:00', '20:00'),
  ('barber3', 0, '11:00', '18:00'); -- Sunday

-- ===== SAMPLE BOOKINGS =====
INSERT OR IGNORE INTO bookings (
  id, user_id, barber_id, service_id, 
  booking_date, booking_time, status, 
  total_amount, payment_method, payment_status
) VALUES
  (
    'booking1',
    'user1',
    'barber1',
    'service1',
    '2026-01-25',
    '10:00',
    'confirmed',
    50000,
    'gopay',
    'paid'
  ),
  (
    'booking2',
    'user2',
    'barber2',
    'service4',
    '2026-01-26',
    '14:00',
    'confirmed',
    45000,
    'card',
    'paid'
  ),
  (
    'booking3',
    'user3',
    'barber3',
    'service7',
    '2026-01-27',
    '11:00',
    'pending',
    60000,
    'cash',
    'pending'
  );

-- ===== SAMPLE REVIEWS =====
INSERT OR IGNORE INTO reviews (booking_id, user_id, barber_id, rating, review_text) VALUES
  (
    'booking1',
    'user1',
    'barber1',
    5,
    'Excellent service! Rizky really knows what he''s doing. Highly recommended!'
  ),
  (
    'booking2',
    'user2',
    'barber2',
    4,
    'Good haircut, very trendy style. Waited a bit longer than expected but worth it.'
  );

-- ===== SAMPLE LOYALTY TRANSACTIONS =====
INSERT OR IGNORE INTO loyalty_transactions (user_id, booking_id, points_change, transaction_type, description) VALUES
  ('user1', 'booking1', 50, 'earn', 'Earned from booking ID booking1'),
  ('user2', 'booking2', 45, 'earn', 'Earned from booking ID booking2');

-- ===== SAMPLE NOTIFICATIONS =====
INSERT OR IGNORE INTO notifications (user_id, notification_type, title, message) VALUES
  (
    'user1',
    'booking_confirmation',
    'Booking Confirmed!',
    'Your booking with Rizky Pratama on 2026-01-25 at 10:00 has been confirmed.'
  ),
  (
    'user2',
    'booking_reminder',
    'Booking Reminder',
    'Reminder: Your appointment with Andi Kurniawan is tomorrow at 14:00.'
  );

-- ===============================================
-- SEED DATA COMPLETE
-- Total: 3 users, 3 barbers, 9 services, 3 bookings
-- ===============================================
