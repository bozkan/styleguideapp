Stripe.api_key = Rails.application.credentials[:stripe_test_secret_key]
Stripe.api_version = "2018-11-08"
Stripe.max_network_retries = 2
