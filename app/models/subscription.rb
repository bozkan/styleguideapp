class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :plan, class_name:'SubscriptionPlan', foreign_key: 'subscription_plan_id'
  has_many :payments, class_name:'SubscriptionPayment', dependent: :nullify

  enum status: { trialing:0, pending:1, active: 2, past_due: 3, canceled:4, unpaid:5, free:6 }

  def valid_subscription?
    status == 'free' || (status == 'active' && !expired?)
  end

  def reactivateable?
    status == 'canceled' && !expired?
  end

  def cancelable?
    status == 'active'
  end

  def expired?
    expiration && (Time.current > expiration)
  end
end
