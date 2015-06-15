config_file = Rails.root.join('config', 'reddit.yml').to_s

REDDIT = YAML.load_file(config_file)[Rails.env.to_s].symbolize_keys
