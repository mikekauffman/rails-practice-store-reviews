unless Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider => 'AWS', # required
      :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'] || "fake", # required
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] || "fake", # required

    }
    config.fog_directory = ENV['MY_BUCKET'] # required
  end
end