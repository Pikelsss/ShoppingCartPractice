# config/initializers/stripe.rb
require 'stripe'

Stripe.api_key = ENV['STRIPE_SECRET_KEY'] # Ensure your environment variable is set

# Define supported countries for Stripe
STRIPE_SUPPORTED_COUNTRIES = ['US', 'CA', 'GB', 'AU', 'FR', 'DE', 'IT', 'ES', 'NL', 'SE', 'NO', 'DK', 'FI', 'IE', 'AT', 'BE', 'CH', 'PL', 'CZ', 'HU', 'PT', 'SG', 'JP', 'HK', 'NZ']
