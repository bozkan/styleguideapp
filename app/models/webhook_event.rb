class WebhookEvent < ApplicationRecord
  validates_uniqueness_of :webhook_id
end
