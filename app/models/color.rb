class Color < ApplicationRecord

  belongs_to :brand
  has_one :category, class_name:'ColorCategory'
  validates_presence_of :hex
  validate :hex_format, on: :create

  acts_as_tenant(:brand)

  private

    def hex_format
      unless hex =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
        errors.add :hex, "Must be a valid hex color code"
      end
    end
end
