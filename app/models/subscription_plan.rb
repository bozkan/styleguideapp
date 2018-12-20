class SubscriptionPlan < ApplicationRecord
  has_many :subscriptions, dependent: :nullify
  #monetize :amount_cents
  enum interval: { day:0, week:1, month:2, year:3}

  validates_uniqueness_of :stripe_id

  attr_accessor :sync_with_stripe

  monetize :amount_cents
end
