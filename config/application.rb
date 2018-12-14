require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Styleguideapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :utc # Or :utc
		config.eager_load_paths += %W(#{config.root}/lib)
  end
end
