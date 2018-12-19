class Account < ApplicationRecord

  belongs_to :owner, class_name:'User', optional: true
  has_many :brands, dependent: :destroy
  accepts_nested_attributes_for :owner
  validates_associated :owner

  attr_accessor :newsletter, :terms


end
