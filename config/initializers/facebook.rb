facebook_config = File.read(Rails.root.to_s + "/config/facebook.yml")
FACEBOOK_CONFIG = YAML.load(facebook_config).symbolize_keys