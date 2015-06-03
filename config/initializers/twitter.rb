twitter_config = File.read(Rails.root.to_s + "/config/twitter.yml")
TWITTER_CONFIG = YAML.load(twitter_config).symbolize_keys