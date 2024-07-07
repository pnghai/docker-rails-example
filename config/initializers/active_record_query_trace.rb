if Rails.env.development?
  ActiveRecordQueryTrace.enabled = true
  # Optional: other gem config options go here
  ActiveRecordQueryTrace.level = :app
  ActiveRecordQueryTrace.ignore_cached_queries = true
  ActiveRecordQueryTrace.colorize = :light_purple
end
# https://github.com/brunofacca/active-record-query-trace/tree/master?tab=readme-ov-file