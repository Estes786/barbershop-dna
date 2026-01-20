// PM2 Configuration for Barbershop DNA
// Usage: pm2 start ecosystem.config.cjs

module.exports = {
  apps: [
    {
      name: 'barbershop-dna',
      script: 'npx',
      args: 'wrangler pages dev dist --d1=barbershop-dna-production --local --ip 0.0.0.0 --port 3000',
      env: {
        NODE_ENV: 'development',
        PORT: 3000
      },
      watch: false, // Disable PM2 file monitoring (wrangler handles hot reload)
      instances: 1, // Development mode uses single instance
      exec_mode: 'fork'
    }
  ]
}
