require 'image_processing/mini_magick'

class ImageUploader < Shrine

  def generate_location(io, context)
    type    = context[:record].class.name.downcase if context[:record]
    brand_id  = tenant_id(context[:record])
    tenant  = defined?(context[:record].brand_id) ? "tenant_#{brand_id}" : "tenant_0"
    name    = super # the default unique identifier

    [tenant, name].compact.join("/")
  end

  #plugin :processing # allows hooking into promoting
  #plugin :versions   # enable Shrine to handle a hash of files
  #plugin :delete_raw # delete processed files after uploading
  plugin :validation_helpers
  plugin :store_dimensions

  process(:store) do |io, context|
    versions = { original: io } # retain original

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:large]  = pipeline.resize_to_limit!(1280, nil)
      versions[:small]  = pipeline.resize_to_limit!(400, nil)
      versions[:thumb]  = pipeline.resize_to_fill!(150, 150, gravity: 'Center')
    end

    versions # return the hash of processed files
  end

  Attacher.validate do
    validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[image/jpeg image/png]
    validate_extension_inclusion %w[jpg jpeg png]
  end

  private
    def tenant_id(record)
      if defined?(record.brand_id)
        record.brand_id
      elsif defined?(record.id)
        record.id
      else
        0
      end
    end
end
