class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    '/uploads/avatar_default.jpeg'
  end

  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def extension_whitelist
     %w(jpg jpeg png)
  end
end
