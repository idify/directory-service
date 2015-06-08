google_config = File.read(Rails.root.to_s + "/config/google.yml")
GOOGLE_CONFIG = YAML.load(google_config).symbolize_keys