class Logo < ApplicationRecord
  belongs_to :brand

  include ImageUploader[:file]

  acts_as_tenant(:brand)

  validate :hex_format
  validates_presence_of :name, :file

  private

    def hex_format
      if display_color.present?
        unless display_color =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
          errors.add :display_color, "Must be a valid hex color code"
        end
      end
    end
end
