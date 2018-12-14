Sidekiq.configure_client do |config|
  #config.redis = { size: (ENV['RAILS_MAX_THREADS'].to_i || 5) }
end

Sidekiq.configure_server do |config|
  #config.redis = { size: (ENV['RAILS_MAX_THREADS'].to_i || 5) }
end
