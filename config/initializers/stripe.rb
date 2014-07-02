Rails.configuration.stripe = {
  :publishable_key => ENV['TEST_PUBLISHABLE_KEY'],
  :secret_key      => ENV['TEST_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
