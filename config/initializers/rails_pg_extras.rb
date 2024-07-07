RailsPgExtras.configure do |config|
  # Rails-pg-extras does not enable all the web actions by default. You can check all available actions via `RailsPgExtras::Web::ACTIONS`.
  # For example, you may want to enable the dangerous `kill_all` action.

  config.enabled_web_actions = %i[kill_all pg_stat_statements_reset add_extensions]
end