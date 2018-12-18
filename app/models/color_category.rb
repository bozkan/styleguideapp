class ColorCategory < ApplicationRecord

  belongs_to :brand
  has_many :colors, dependent: :nullify

  acts_as_tenant(:brand)

  validates_presence_of :name
end
