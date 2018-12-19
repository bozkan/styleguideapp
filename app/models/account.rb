class Account < ApplicationRecord

  belongs_to :owner, class_name:'User', optional: true
  has_many :brands, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :plan, class_name:'SubscriptionPlan', through: :subscription
  has_many :payments, class_name:'SubscriptionPayment', through: :subscription, source: :account, dependent: :nullify

  accepts_nested_attributes_for :owner, :subscription
  validates_associated :owner

  attr_accessor :newsletter, :terms


end
