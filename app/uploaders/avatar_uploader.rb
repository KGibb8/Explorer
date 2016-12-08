class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :profile do
    process :resize_to_fit => [200, 200]
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/profile_default.png")
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
