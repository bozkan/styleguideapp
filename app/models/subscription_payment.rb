class SubscriptionPayment < ApplicationRecord
  belongs_to :subscription
  belongs_to :account

  validates_uniqueness_of :transaction_id, allow_nil: true

  monetize :amount_cents
end
