import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'

type Bindings = {
  DB: D1Database;
  R2?: R2Bucket;
  KV?: KVNamespace;
}

const app = new Hono<{ Bindings: Bindings }>()

// Enable CORS for API routes
app.use('/api/*', cors())

// Serve static files from public directory
app.use('/static/*', serveStatic({ root: './public' }))

// ===== API ROUTES =====
app.get('/api/health', (c) => {
  return c.json({ 
    status: 'ok', 
    service: 'Barbershop DNA API',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  })
})

app.get('/api/barbers', async (c) => {
  // TODO: Implement barber listing from D1 database
  return c.json({
    success: true,
    message: 'Barber listing endpoint - Coming soon',
    data: []
  })
})

app.get('/api/services', async (c) => {
  // TODO: Implement services listing
  return c.json({
    success: true,
    message: 'Services listing endpoint - Coming soon',
    data: []
  })
})

// ===== MAIN LANDING PAGE =====
app.get('/', (c) => {
  return c.html(`
    <!DOCTYPE html>
    <html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Barbershop DNA - Digital Marketplace Barbershop Indonesia</title>
        <meta name="description" content="Platform booking barbershop terbaik di Indonesia. Temukan barber terdekat, booking online, dan nikmati AI Virtual Try-On!">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/css/all.min.css" rel="stylesheet">
        <script>
          tailwind.config = {
            theme: {
              extend: {
                colors: {
                  primary: '#1e40af',
                  secondary: '#f59e0b',
                }
              }
            }
          }
        </script>
    </head>
    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
        
        <!-- Header/Navbar -->
        <nav class="bg-white shadow-md fixed w-full top-0 z-50">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <div class="flex items-center space-x-2">
                    <i class="fas fa-cut text-3xl text-primary"></i>
                    <h1 class="text-2xl font-bold text-gray-800">Barbershop <span class="text-primary">DNA</span></h1>
                </div>
                <div class="hidden md:flex space-x-6">
                    <a href="#features" class="text-gray-700 hover:text-primary transition">Fitur</a>
                    <a href="#how-it-works" class="text-gray-700 hover:text-primary transition">Cara Kerja</a>
                    <a href="#pricing" class="text-gray-700 hover:text-primary transition">Harga</a>
                    <a href="#contact" class="text-gray-700 hover:text-primary transition">Kontak</a>
                </div>
                <div class="flex space-x-2">
                    <button onclick="alert('Login coming soon!')" class="px-4 py-2 text-primary border border-primary rounded-lg hover:bg-primary hover:text-white transition">Login</button>
                    <button onclick="alert('Register coming soon!')" class="px-4 py-2 bg-primary text-white rounded-lg hover:bg-blue-700 transition">Daftar</button>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="pt-24 pb-16 px-4">
            <div class="container mx-auto text-center">
                <div class="max-w-4xl mx-auto">
                    <h1 class="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
                        Revolusi Digital untuk <span class="text-primary">Barbershop</span> Indonesia 🔥
                    </h1>
                    <p class="text-xl text-gray-600 mb-8">
                        Platform marketplace #1 yang menghubungkan pelanggan dengan barbershop terbaik. 
                        <strong>Booking online, AI Virtual Try-On, sistem loyalitas,</strong> dan banyak lagi!
                    </p>
                    <div class="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4 mb-8">
                        <button onclick="alert('Find Barber coming soon!')" class="px-8 py-4 bg-primary text-white text-lg font-semibold rounded-lg shadow-lg hover:bg-blue-700 transition transform hover:scale-105">
                            <i class="fas fa-search mr-2"></i>Cari Barbershop
                        </button>
                        <button onclick="alert('Register as Barber coming soon!')" class="px-8 py-4 bg-secondary text-white text-lg font-semibold rounded-lg shadow-lg hover:bg-yellow-600 transition transform hover:scale-105">
                            <i class="fas fa-user-tie mr-2"></i>Daftar Sebagai Barber
                        </button>
                    </div>
                    <div class="flex justify-center space-x-8 text-gray-700">
                        <div class="text-center">
                            <div class="text-3xl font-bold text-primary">500+</div>
                            <div class="text-sm">Barbershop</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-primary">50K+</div>
                            <div class="text-sm">Bookings</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-primary">4.9/5</div>
                            <div class="text-sm">Rating</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section id="features" class="py-16 bg-white">
            <div class="container mx-auto px-4">
                <h2 class="text-4xl font-bold text-center text-gray-900 mb-12">Fitur Unggulan 🚀</h2>
                <div class="grid md:grid-cols-3 gap-8">
                    <!-- Feature 1 -->
                    <div class="bg-gradient-to-br from-blue-50 to-blue-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-primary mb-4"><i class="fas fa-calendar-check"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">Booking Online 24/7</h3>
                        <p class="text-gray-600">Pesan jadwal kapan saja, di mana saja. Automated reminders via SMS & email. Tidak ada lagi antrian panjang!</p>
                    </div>
                    <!-- Feature 2 -->
                    <div class="bg-gradient-to-br from-yellow-50 to-yellow-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-secondary mb-4"><i class="fas fa-robot"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">AI Virtual Try-On</h3>
                        <p class="text-gray-600">Lihat tampilan gaya rambut sebelum potong! Upload foto, pilih style, dan visualisasikan hasilnya dengan AI.</p>
                    </div>
                    <!-- Feature 3 -->
                    <div class="bg-gradient-to-br from-green-50 to-green-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-green-600 mb-4"><i class="fas fa-star"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">Sistem Loyalitas</h3>
                        <p class="text-gray-600">Kumpulkan poin setiap booking. Bronze → Silver → Gold tier dengan rewards eksklusif!</p>
                    </div>
                    <!-- Feature 4 -->
                    <div class="bg-gradient-to-br from-purple-50 to-purple-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-purple-600 mb-4"><i class="fas fa-search-location"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">Cari Terdekat</h3>
                        <p class="text-gray-600">Temukan barbershop terdekat dengan filter harga, rating, dan jarak. Map view & list view tersedia!</p>
                    </div>
                    <!-- Feature 5 -->
                    <div class="bg-gradient-to-br from-red-50 to-red-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-red-600 mb-4"><i class="fas fa-credit-card"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">Payment Terintegrasi</h3>
                        <p class="text-gray-600">Bayar dengan card, GoPay, OVO, Dana, atau cash. Secure & PCI compliant!</p>
                    </div>
                    <!-- Feature 6 -->
                    <div class="bg-gradient-to-br from-indigo-50 to-indigo-100 p-6 rounded-xl shadow-lg hover:shadow-xl transition transform hover:-translate-y-2">
                        <div class="text-5xl text-indigo-600 mb-4"><i class="fas fa-comments"></i></div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-3">AI Chatbot</h3>
                        <p class="text-gray-600">Konsultasi style 24/7 dengan AI assistant. Rekomendasi gaya rambut berdasarkan bentuk wajah!</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works -->
        <section id="how-it-works" class="py-16 bg-gradient-to-br from-primary to-blue-900 text-white">
            <div class="container mx-auto px-4">
                <h2 class="text-4xl font-bold text-center mb-12">Cara Kerja ✨</h2>
                <div class="grid md:grid-cols-4 gap-8">
                    <div class="text-center">
                        <div class="text-6xl mb-4">1️⃣</div>
                        <h3 class="text-xl font-bold mb-2">Cari Barbershop</h3>
                        <p class="text-blue-100">Filter berdasarkan lokasi, rating, harga</p>
                    </div>
                    <div class="text-center">
                        <div class="text-6xl mb-4">2️⃣</div>
                        <h3 class="text-xl font-bold mb-2">Pilih Barber & Service</h3>
                        <p class="text-blue-100">Lihat portfolio, reviews, dan jadwal</p>
                    </div>
                    <div class="text-center">
                        <div class="text-6xl mb-4">3️⃣</div>
                        <h3 class="text-xl font-bold mb-2">Booking & Bayar</h3>
                        <p class="text-blue-100">Pilih tanggal, waktu, dan metode pembayaran</p>
                    </div>
                    <div class="text-center">
                        <div class="text-6xl mb-4">4️⃣</div>
                        <h3 class="text-xl font-bold mb-2">Datang & Review</h3>
                        <p class="text-blue-100">Dapatkan poin loyalitas dan beri review</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Pricing Section -->
        <section id="pricing" class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <h2 class="text-4xl font-bold text-center text-gray-900 mb-4">Paket untuk Barber 💎</h2>
                <p class="text-center text-gray-600 mb-12">Pilih paket yang sesuai dengan kebutuhan bisnis Anda</p>
                <div class="grid md:grid-cols-4 gap-6 max-w-6xl mx-auto">
                    <!-- FREE -->
                    <div class="bg-white p-6 rounded-xl shadow-lg border-2 border-gray-200">
                        <h3 class="text-2xl font-bold text-gray-800 mb-2">FREE</h3>
                        <div class="text-4xl font-bold text-gray-900 mb-4">$0<span class="text-sm text-gray-500">/bulan</span></div>
                        <ul class="space-y-3 mb-6 text-gray-600">
                            <li><i class="fas fa-check text-green-500 mr-2"></i>5 bookings/bulan</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Profil basic</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Manual availability</li>
                        </ul>
                        <button class="w-full py-3 bg-gray-200 text-gray-700 rounded-lg font-semibold">Mulai Gratis</button>
                    </div>
                    <!-- STARTER -->
                    <div class="bg-white p-6 rounded-xl shadow-lg border-2 border-blue-500">
                        <div class="bg-blue-500 text-white text-xs font-bold py-1 px-3 rounded-full inline-block mb-2">POPULER</div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-2">STARTER</h3>
                        <div class="text-4xl font-bold text-gray-900 mb-4">$19<span class="text-sm text-gray-500">/bulan</span></div>
                        <ul class="space-y-3 mb-6 text-gray-600">
                            <li><i class="fas fa-check text-green-500 mr-2"></i>50 bookings/bulan</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>AI chatbot basic</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Analytics dasar</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Email support</li>
                        </ul>
                        <button class="w-full py-3 bg-primary text-white rounded-lg font-semibold hover:bg-blue-700 transition">Pilih Paket</button>
                    </div>
                    <!-- PRO -->
                    <div class="bg-white p-6 rounded-xl shadow-lg border-2 border-yellow-500">
                        <div class="bg-yellow-500 text-white text-xs font-bold py-1 px-3 rounded-full inline-block mb-2">BEST VALUE</div>
                        <h3 class="text-2xl font-bold text-gray-800 mb-2">PRO</h3>
                        <div class="text-4xl font-bold text-gray-900 mb-4">$49<span class="text-sm text-gray-500">/bulan</span></div>
                        <ul class="space-y-3 mb-6 text-gray-600">
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Unlimited bookings</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Advanced AI features</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Advanced analytics</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Marketing tools</li>
                            <li><i class="fas fa-check text-green-500 mr-2"></i>Priority support</li>
                        </ul>
                        <button class="w-full py-3 bg-secondary text-white rounded-lg font-semibold hover:bg-yellow-600 transition">Pilih Paket</button>
                    </div>
                    <!-- ENTERPRISE -->
                    <div class="bg-gradient-to-br from-purple-600 to-purple-800 p-6 rounded-xl shadow-lg text-white">
                        <h3 class="text-2xl font-bold mb-2">ENTERPRISE</h3>
                        <div class="text-4xl font-bold mb-4">$99<span class="text-sm opacity-80">/bulan</span></div>
                        <ul class="space-y-3 mb-6">
                            <li><i class="fas fa-check mr-2"></i>Semua fitur PRO</li>
                            <li><i class="fas fa-check mr-2"></i>Multi-location</li>
                            <li><i class="fas fa-check mr-2"></i>Custom integrations</li>
                            <li><i class="fas fa-check mr-2"></i>Custom training</li>
                            <li><i class="fas fa-check mr-2"></i>Dedicated manager</li>
                        </ul>
                        <button class="w-full py-3 bg-white text-purple-700 rounded-lg font-semibold hover:bg-gray-100 transition">Hubungi Sales</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="py-16 bg-primary text-white">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-4xl font-bold mb-4">Siap Bergabung? 🚀</h2>
                <p class="text-xl mb-8 opacity-90">Jadilah bagian dari revolusi digital barbershop Indonesia!</p>
                <div class="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4">
                    <button onclick="alert('Customer registration coming soon!')" class="px-8 py-4 bg-white text-primary text-lg font-semibold rounded-lg shadow-lg hover:bg-gray-100 transition">
                        Daftar Sebagai Customer
                    </button>
                    <button onclick="alert('Barber registration coming soon!')" class="px-8 py-4 bg-secondary text-white text-lg font-semibold rounded-lg shadow-lg hover:bg-yellow-600 transition">
                        Daftar Sebagai Barber
                    </button>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer id="contact" class="bg-gray-900 text-white py-12">
            <div class="container mx-auto px-4">
                <div class="grid md:grid-cols-4 gap-8 mb-8">
                    <div>
                        <div class="flex items-center space-x-2 mb-4">
                            <i class="fas fa-cut text-2xl text-primary"></i>
                            <h3 class="text-xl font-bold">Barbershop DNA</h3>
                        </div>
                        <p class="text-gray-400">Platform marketplace barbershop terbaik di Indonesia.</p>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Produk</h4>
                        <ul class="space-y-2 text-gray-400">
                            <li><a href="#" class="hover:text-white">Fitur</a></li>
                            <li><a href="#" class="hover:text-white">Harga</a></li>
                            <li><a href="#" class="hover:text-white">API</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Perusahaan</h4>
                        <ul class="space-y-2 text-gray-400">
                            <li><a href="#" class="hover:text-white">Tentang Kami</a></li>
                            <li><a href="#" class="hover:text-white">Karir</a></li>
                            <li><a href="#" class="hover:text-white">Blog</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold mb-4">Kontak</h4>
                        <ul class="space-y-2 text-gray-400">
                            <li><i class="fas fa-envelope mr-2"></i>info@barbershopdna.com</li>
                            <li><i class="fas fa-phone mr-2"></i>+62 812 3456 7890</li>
                            <li><i class="fas fa-map-marker-alt mr-2"></i>Jakarta, Indonesia</li>
                        </ul>
                    </div>
                </div>
                <div class="border-t border-gray-800 pt-8 text-center text-gray-400">
                    <p>&copy; 2026 Barbershop DNA. All rights reserved. Built with ❤️ in Indonesia.</p>
                </div>
            </div>
        </footer>

        <script>
          // Simple smooth scroll
          document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
              e.preventDefault();
              const target = document.querySelector(this.getAttribute('href'));
              if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
              }
            });
          });
        </script>
    </body>
    </html>
  `)
})

export default app
