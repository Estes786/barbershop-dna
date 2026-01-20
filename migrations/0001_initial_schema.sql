-- ===============================================
-- BARBERSHOP DNA - INITIAL DATABASE SCHEMA
-- Migration: 0001_initial_schema.sql
-- Date: 2026-01-20
-- Description: Core tables for marketplace platform
-- ===============================================

-- ===== USERS TABLE (Customers) =====
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  email TEXT UNIQUE NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  full_name TEXT NOT NULL,
  profile_photo_url TEXT,
  date_of_birth DATE,
  face_shape TEXT CHECK (face_shape IN ('oval', 'round', 'square', 'heart', 'diamond')),
  loyalty_tier TEXT CHECK (loyalty_tier IN ('bronze', 'silver', 'gold')) DEFAULT 'bronze',
  loyalty_points INTEGER DEFAULT 0,
  total_bookings INTEGER DEFAULT 0,
  total_spent REAL DEFAULT 0.0,
  referral_code TEXT UNIQUE DEFAULT (upper(substr(hex(randomblob(4)), 1, 8))),
  referred_by TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (referred_by) REFERENCES users(id)
);

-- ===== BARBERS TABLE =====
CREATE TABLE IF NOT EXISTS barbers (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  email TEXT UNIQUE NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  full_name TEXT NOT NULL,
  profile_photo_url TEXT,
  bio TEXT,
  years_experience INTEGER DEFAULT 0,
  specialties TEXT, -- JSON array: ["fades", "beard", "coloring"]
  portfolio_photos TEXT, -- JSON array of R2 URLs
  barbershop_name TEXT,
  address TEXT,
  latitude REAL,
  longitude REAL,
  subscription_tier TEXT CHECK (subscription_tier IN ('free', 'starter', 'pro', 'enterprise')) DEFAULT 'free',
  subscription_expires_at DATETIME,
  average_rating REAL DEFAULT 5.0,
  total_reviews INTEGER DEFAULT 0,
  total_bookings INTEGER DEFAULT 0,
  total_revenue REAL DEFAULT 0.0,
  commission_rate REAL DEFAULT 0.70, -- Barber keeps 70%, platform takes 30%
  is_verified BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===== SERVICES TABLE =====
CREATE TABLE IF NOT EXISTS services (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  barber_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  duration_minutes INTEGER NOT NULL,
  price REAL NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (barber_id) REFERENCES barbers(id) ON DELETE CASCADE
);

-- ===== AVAILABILITY TABLE (Barber Working Hours) =====
CREATE TABLE IF NOT EXISTS availability (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  barber_id TEXT NOT NULL,
  day_of_week INTEGER CHECK (day_of_week BETWEEN 0 AND 6) NOT NULL, -- 0=Sunday, 6=Saturday
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (barber_id) REFERENCES barbers(id) ON DELETE CASCADE
);

-- ===== BOOKINGS TABLE =====
CREATE TABLE IF NOT EXISTS bookings (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT NOT NULL,
  barber_id TEXT NOT NULL,
  service_id TEXT NOT NULL,
  booking_date DATE NOT NULL,
  booking_time TIME NOT NULL,
  status TEXT CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled', 'no_show')) DEFAULT 'pending',
  total_amount REAL NOT NULL,
  payment_method TEXT CHECK (payment_method IN ('card', 'gopay', 'ovo', 'dana', 'cash')),
  payment_status TEXT CHECK (payment_status IN ('pending', 'paid', 'refunded')) DEFAULT 'pending',
  payment_intent_id TEXT, -- Stripe Payment Intent ID
  notes TEXT,
  cancellation_reason TEXT,
  cancelled_at DATETIME,
  completed_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (barber_id) REFERENCES barbers(id),
  FOREIGN KEY (service_id) REFERENCES services(id)
);

-- ===== REVIEWS TABLE =====
CREATE TABLE IF NOT EXISTS reviews (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  booking_id TEXT NOT NULL UNIQUE,
  user_id TEXT NOT NULL,
  barber_id TEXT NOT NULL,
  rating INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
  review_text TEXT,
  photos TEXT, -- JSON array of image URLs
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (barber_id) REFERENCES barbers(id)
);

-- ===== LOYALTY TRANSACTIONS TABLE =====
CREATE TABLE IF NOT EXISTS loyalty_transactions (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT NOT NULL,
  booking_id TEXT,
  points_change INTEGER NOT NULL,
  transaction_type TEXT CHECK (transaction_type IN ('earn', 'redeem', 'bonus', 'expired')) NOT NULL,
  description TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- ===== REFERRALS TABLE =====
CREATE TABLE IF NOT EXISTS referrals (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  referrer_id TEXT NOT NULL,
  referred_id TEXT NOT NULL,
  referral_code TEXT NOT NULL,
  status TEXT CHECK (status IN ('pending', 'completed', 'rewarded')) DEFAULT 'pending',
  referrer_reward REAL DEFAULT 10.00,
  referred_reward REAL DEFAULT 0.20,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  completed_at DATETIME,
  FOREIGN KEY (referrer_id) REFERENCES users(id),
  FOREIGN KEY (referred_id) REFERENCES users(id)
);

-- ===== NOTIFICATIONS TABLE =====
CREATE TABLE IF NOT EXISTS notifications (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT,
  barber_id TEXT,
  notification_type TEXT CHECK (notification_type IN ('booking_reminder', 'booking_confirmation', 'review_request', 'loyalty_milestone', 'promotional', 'system')) NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  deep_link TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (barber_id) REFERENCES barbers(id)
);

-- ===== SUBSCRIPTIONS TABLE (Customer Membership) =====
CREATE TABLE IF NOT EXISTS subscriptions (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  user_id TEXT NOT NULL,
  plan_type TEXT CHECK (plan_type IN ('basic', 'premium', 'vip')) NOT NULL,
  monthly_price REAL NOT NULL,
  bookings_included INTEGER NOT NULL,
  discount_percentage REAL DEFAULT 0.0,
  status TEXT CHECK (status IN ('active', 'cancelled', 'expired')) DEFAULT 'active',
  current_period_start DATE NOT NULL,
  current_period_end DATE NOT NULL,
  auto_renew BOOLEAN DEFAULT TRUE,
  stripe_subscription_id TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ===============================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ===============================================

-- Users indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_users_referral_code ON users(referral_code);
CREATE INDEX IF NOT EXISTS idx_users_loyalty_tier ON users(loyalty_tier);

-- Barbers indexes
CREATE INDEX IF NOT EXISTS idx_barbers_email ON barbers(email);
CREATE INDEX IF NOT EXISTS idx_barbers_phone ON barbers(phone);
CREATE INDEX IF NOT EXISTS idx_barbers_location ON barbers(latitude, longitude);
CREATE INDEX IF NOT EXISTS idx_barbers_subscription_tier ON barbers(subscription_tier);
CREATE INDEX IF NOT EXISTS idx_barbers_is_verified ON barbers(is_verified);
CREATE INDEX IF NOT EXISTS idx_barbers_is_active ON barbers(is_active);

-- Services indexes
CREATE INDEX IF NOT EXISTS idx_services_barber_id ON services(barber_id);
CREATE INDEX IF NOT EXISTS idx_services_is_active ON services(is_active);

-- Availability indexes
CREATE INDEX IF NOT EXISTS idx_availability_barber_id ON availability(barber_id);
CREATE INDEX IF NOT EXISTS idx_availability_day_of_week ON availability(day_of_week);

-- Bookings indexes (CRITICAL for performance)
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_barber_id ON bookings(barber_id);
CREATE INDEX IF NOT EXISTS idx_bookings_service_id ON bookings(service_id);
CREATE INDEX IF NOT EXISTS idx_bookings_barber_date ON bookings(barber_id, booking_date);
CREATE INDEX IF NOT EXISTS idx_bookings_user_date ON bookings(user_id, booking_date);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_payment_status ON bookings(payment_status);

-- Reviews indexes
CREATE INDEX IF NOT EXISTS idx_reviews_barber_id ON reviews(barber_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user_id ON reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_reviews_booking_id ON reviews(booking_id);

-- Loyalty transactions indexes
CREATE INDEX IF NOT EXISTS idx_loyalty_user_id ON loyalty_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_loyalty_transaction_type ON loyalty_transactions(transaction_type);

-- Referrals indexes
CREATE INDEX IF NOT EXISTS idx_referrals_referrer_id ON referrals(referrer_id);
CREATE INDEX IF NOT EXISTS idx_referrals_referred_id ON referrals(referred_id);
CREATE INDEX IF NOT EXISTS idx_referrals_code ON referrals(referral_code);

-- Notifications indexes
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_barber_id ON notifications(barber_id);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON notifications(is_read);

-- Subscriptions indexes
CREATE INDEX IF NOT EXISTS idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_status ON subscriptions(status);

-- ===============================================
-- MIGRATION COMPLETE
-- ===============================================
