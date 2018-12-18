require 'shrine/storage/s3'
include ActsAsTenant

s3_options = {
  access_key_id: Rails.application.credentials[:aws_access_key_id],
  secret_access_key: Rails.application.credentials[:aws_secret_access_key],
  bucket: 'styleguides-production',
  region: 'us-east-1'
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "uploads/cache", upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "uploads/store", upload_options: {acl: 'public-read'}, **s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :pretty_location
Shrine.plugin :remove_invalid
Shrine.plugin :remove_attachment
Shrine.plugin :processing # allows hooking into promoting
Shrine.plugin :versions   # enable Shrine to handle a hash of files
Shrine.plugin :delete_raw # delete processed files after uploading
Shrine.plugin :validation_helpers
Shrine.plugin :backgrounding

Shrine.plugin :default_url_options, cache: {public:true}, store: { host: 'https://dn1bgjl7o7so6.cloudfront.net' }

Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params["filename"]
  type     = request.params["type"]

  {
    content_disposition:    "inline; filename=\"#{filename}\"", # set download filename
    content_type:           type,                               # set content type (defaults to "application/octet-stream")
    content_length_range:   0..(10*1024*1024),                  # limit upload size to 10 MB
  }
}
Shrine::Attacher.promote { |data| ShrineFilePromoteJob.perform_later(data) }
Shrine::Attacher.delete { |data| ShrineFileDeleteJob.perform_later(data) }
