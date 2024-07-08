require 'sidekiq/cron/job'
# schedule_file = "config/schedule.yml"

if ENV.fetch("REDIS_URL")
  redis_path = ENV.fetch("REDIS_URL")
  Sidekiq.configure_server do |config|
    config.redis = { url: redis_path }
    # if File.exist?(schedule_file)
    #   loaded = YAML.load_file(schedule_file)
    #   Sidekiq::Cron::Job.load_from_hash loaded if loaded
    # end
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: redis_path }
  end
end
