# 🔥 Barbershop DNA - Digital Marketplace

> **The Ultimate Digital Transformation Platform for Indonesian Barbershops**

[![Tech Stack](https://img.shields.io/badge/Stack-Hono%20%2B%20Cloudflare-orange)]()
[![Status](https://img.shields.io/badge/Status-MVP%20Development-yellow)]()
[![License](https://img.shields.io/badge/License-MIT-blue)]()

---

## 📊 Project Overview

**Barbershop DNA** is a two-sided marketplace platform connecting **customers** with **barbers/barbershops** across Indonesia. Built with modern edge-first technology for speed, scalability, and mobile-first experience.

### 🎯 Core Mission
Transform traditional barbershops into **tech-enabled grooming empires** by providing:
- 24/7 online booking system
- Payment processing & automation
- Loyalty & retention programs
- AI-powered features (Virtual Try-On, Chatbot)
- Business analytics & insights

---

## 🚀 Tech Stack

### **Frontend**
- Vanilla JavaScript (mobile-optimized, fast loading)
- TailwindCSS via CDN (utility-first styling)
- Chart.js (analytics visualization)
- Axios (API communication)

### **Backend**
- **Hono** - Ultrafast web framework for Cloudflare Workers
- **TypeScript** - Type-safe development
- **Cloudflare Workers** - Edge computing, <50ms latency globally

### **Database & Storage**
- **Cloudflare D1** - Distributed SQLite database (10GB free)
- **Cloudflare R2** - Object storage for images (10GB free)
- **Cloudflare KV** - Key-value cache for sessions (1GB free)

### **External APIs**
- **Stripe** - Global payment processing
- **Midtrans** - Indonesian payment gateway (GoPay, OVO, Dana)
- **Twilio** - SMS notifications & reminders
- **Resend** - Transactional email delivery
- **Google Maps API** - Location-based barbershop discovery

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────┐
│  CUSTOMER APP (Mobile PWA)                      │
│  • Barbershop Discovery (Map + List)            │
│  • Booking Flow                                 │
│  • Loyalty & Rewards                            │
│  • Reviews & Ratings                            │
└─────────────────────────────────────────────────┘
          ↓ HTTPS API Calls
┌─────────────────────────────────────────────────┐
│  HONO BACKEND (Cloudflare Workers)              │
│  • /api/auth/* - Authentication (JWT)           │
│  • /api/barbers/* - Barber profiles & search    │
│  • /api/bookings/* - Booking management         │
│  • /api/payments/* - Stripe integration         │
│  • /api/loyalty/* - Points & rewards            │
│  • /api/reviews/* - Rating system               │
└─────────────────────────────────────────────────┘
          ↓ SQL Queries
┌─────────────────────────────────────────────────┐
│  CLOUDFLARE D1 (SQLite)                         │
│  Tables: users, barbers, services, bookings,    │
│          reviews, loyalty_transactions,         │
│          referrals, subscriptions, notifications│
└─────────────────────────────────────────────────┘
          ↓ File Storage
┌─────────────────────────────────────────────────┐
│  CLOUDFLARE R2 (Object Storage)                 │
│  • Profile photos                               │
│  • Portfolio images (before/after)              │
│  • Review photos                                │
└─────────────────────────────────────────────────┘
```

---

## 💰 Business Model

### Revenue Streams:

**1. Subscription Tiers (Barbers):**
- **FREE** - $0/mo - Up to 5 bookings/month
- **STARTER** - $19/mo - Up to 50 bookings + AI chatbot
- **PRO** - $49/mo - Unlimited bookings + analytics
- **ENTERPRISE** - $99/mo - Multi-location + custom features

**2. Transaction Fees:**
- **2.9% + $0.30** per booking payment
- Average booking: Rp 35,000 (~$2.30)
- Platform revenue: ~$0.10/booking

**3. Customer Subscriptions (Future):**
- **BASIC** - $39/mo - 1 haircut/month + 15% off
- **PREMIUM** - $79/mo - 2 haircuts/month + 20% off
- **VIP** - $149/mo - Unlimited haircuts + concierge

### Financial Projections:
```
Year 1: 500 barbers → $263K revenue
Year 2: 2,000 barbers → $2.1M revenue
Year 3: 5,000 barbers → $7.8M revenue
```

---

## 🗂️ Project Structure

```
barbershop-dna/
├── src/
│   ├── index.tsx              # Main Hono app entry
│   ├── routes/                # API route handlers
│   │   ├── auth.ts            # Authentication endpoints
│   │   ├── barbers.ts         # Barber management
│   │   ├── bookings.ts        # Booking logic
│   │   ├── payments.ts        # Stripe integration
│   │   └── loyalty.ts         # Loyalty system
│   ├── middleware/            # Custom middleware
│   │   ├── auth.ts            # JWT verification
│   │   └── cors.ts            # CORS configuration
│   ├── utils/                 # Helper functions
│   │   ├── jwt.ts             # Token generation
│   │   └── validation.ts      # Input validation
│   └── types/                 # TypeScript definitions
│       └── bindings.ts        # Cloudflare bindings
├── public/                    # Static assets
│   ├── index.html             # Landing page
│   ├── static/
│   │   ├── app.js             # Frontend JavaScript
│   │   └── styles.css         # Custom CSS
│   └── assets/                # Images, icons
├── migrations/                # D1 database migrations
│   ├── 0001_initial_schema.sql
│   ├── 0002_add_loyalty.sql
│   └── meta/                  # Migration metadata
├── .git/                      # Git repository
├── .gitignore                 # Git ignore rules
├── ecosystem.config.cjs       # PM2 configuration
├── wrangler.jsonc             # Cloudflare config
├── package.json               # Dependencies & scripts
├── tsconfig.json              # TypeScript config
├── BLUEPRINT_REQUIREMENTS.md  # Master requirements doc
└── README.md                  # This file
```

---

## 🚦 Getting Started

### Prerequisites:
- Node.js 18+ installed
- Cloudflare account (free tier)
- Wrangler CLI installed (`npm i -g wrangler`)

### Installation:

```bash
# Clone/navigate to project
cd /home/user/webapp

# Install dependencies (already done)
npm install

# Create D1 database (production)
npm run db:create
# Copy the returned database_id to wrangler.jsonc

# Create migrations directory
mkdir migrations

# Apply migrations locally (after creating migration files)
npm run db:migrate:local
```

### Development:

```bash
# Build the project first (REQUIRED)
npm run build

# Start development server with PM2
pm2 start ecosystem.config.cjs

# Test server
curl http://localhost:3000

# Check logs (non-blocking)
pm2 logs barbershop-dna --nostream

# Stop server
pm2 delete barbershop-dna
```

### Deployment:

```bash
# Setup Cloudflare authentication
# Call setup_cloudflare_api_key tool first

# Build for production
npm run build

# Deploy to Cloudflare Pages
npm run deploy:prod

# Apply database migrations to production
npm run db:migrate:prod
```

---

## 📋 MVP Features (Phase 1 - Week 1-12)

### ✅ Completed:
- [x] Project setup with Hono + Cloudflare
- [x] Git repository initialization
- [x] Package.json with scripts
- [x] Wrangler configuration
- [x] PM2 ecosystem config
- [x] Master requirements documentation

### 🔄 In Progress:
- [ ] Database schema design (Phase 2)
- [ ] Authentication system (JWT)
- [ ] Barber profile CRUD
- [ ] Booking engine with availability
- [ ] Payment integration (Stripe)

### ⏳ Upcoming:
- [ ] Frontend landing page (mobile-first)
- [ ] Loyalty points system
- [ ] Review & rating system
- [ ] SMS/Email notifications
- [ ] Barber dashboard
- [ ] Production deployment

---

## 📊 Current Status

**Phase**: MVP Development - Foundation Setup ✅
**Progress**: 10% Complete
**Last Updated**: 2026-01-20
**Next Milestone**: Database Schema Design (Phase 2)

### Key Metrics (Target):
- **Barbers**: 0 → 500 (Year 1 goal)
- **Customers**: 0 → 10,000 (Year 1 goal)
- **Monthly Bookings**: 0 → 20,000 (Year 1 goal)
- **MRR**: $0 → $25,000 (Year 1 goal)

---

## 🎯 Roadmap

### Phase 1: MVP Launch (Week 1-12)
- Database schema + migrations
- Authentication + JWT
- Core booking engine
- Payment integration
- Basic frontend
- Beta launch (Jakarta Selatan)

### Phase 2: Growth Features (Week 13-24)
- Loyalty points system
- Referral program
- Advanced analytics
- Marketing automation
- Expand to 3 cities

### Phase 3: Scale & AI (Week 25-52)
- AI Virtual Try-On
- AI Chatbot consultation
- Customer subscriptions
- Multi-location management
- National expansion (10 cities)

---

## 🔐 Environment Variables

Create `.dev.vars` file for local development:

```bash
# Database (handled by wrangler.jsonc)
# D1_DATABASE_ID=your-d1-database-id

# Stripe (Payment Processing)
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Midtrans (Indonesian Payments)
MIDTRANS_SERVER_KEY=your-midtrans-server-key
MIDTRANS_CLIENT_KEY=your-midtrans-client-key

# Twilio (SMS)
TWILIO_ACCOUNT_SID=your-twilio-sid
TWILIO_AUTH_TOKEN=your-twilio-token
TWILIO_PHONE_NUMBER=+1234567890

# Resend (Email)
RESEND_API_KEY=re_...

# Google Maps (Location)
GOOGLE_MAPS_API_KEY=your-google-maps-key

# JWT Secret
JWT_SECRET=your-super-secret-jwt-key-change-this
```

**IMPORTANT**: Never commit `.dev.vars` or `.env` files to Git!

For production, use:
```bash
npx wrangler secret put STRIPE_SECRET_KEY
```

---

## 🤝 Contributing

This is a private MVP project. For questions or collaboration:
- **Email**: builder@barbershop-dna.com
- **Documentation**: See `BLUEPRINT_REQUIREMENTS.md`

---

## 📄 License

MIT License - See LICENSE file for details

---

## 🎓 References

Based on successful models:
- **Squire** ($750M valuation) - Vertical SaaS for barbershops
- **theCut** (4.5M users) - Individual barber empowerment
- **Competitive analysis** of 50+ Indonesian barbershops
- **Blueprint**: `BARBERSHOP_DNA_MASTER_BLUEPRINT.md`

---

**Built with ❤️ for the Indonesian barbershop community**

*Last Updated: 2026-01-20*
