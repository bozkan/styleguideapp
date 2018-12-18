class Logo < ApplicationRecord
  belongs_to :brand

  include ImageUploader[:file]

  acts_as_tenant(:brand)
end
