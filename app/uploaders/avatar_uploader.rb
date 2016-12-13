class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [75, 75]
  end

  version :profile do
    process :resize_to_fill => [200, 200]
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/profile_default.png")
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
