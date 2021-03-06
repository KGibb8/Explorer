class HeaderUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/header_default.jpg")
  end

  version :banner do
    process :resize_to_fill => [460, 130]
  end

  version :header do
    process :resize_to_fill => [1096, 330]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
