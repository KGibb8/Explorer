CarrierWave.configure do |config|
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  elsif Rails.env.development?
    config.storage = :file
  else
    config.storage = :fog
  end
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end
