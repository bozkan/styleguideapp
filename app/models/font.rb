class Font < ApplicationRecord

  belongs_to :brand

  acts_as_tenant(:brand)

  validates_presence_of :name, :size
end
