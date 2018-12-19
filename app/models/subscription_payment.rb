class SubscriptionPayment < ApplicationRecord
  belongs_to :subscription

  validates_uniqueness_of :transaction_id, allow_nil: true

end
