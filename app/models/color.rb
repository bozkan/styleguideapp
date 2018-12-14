class Color < ApplicationRecord

  belongs_to :brand
  has_one :category, class_name:'ColorCategory'

  acts_as_tenant(:brand)
end
