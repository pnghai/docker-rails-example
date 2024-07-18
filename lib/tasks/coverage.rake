
desc 'Merge the results of various SimpleCov coverage reports'
task merge_coverage_reports: :environment do
  require 'lib/marty/simplecov_helper'
  puts 'Merging code coverage reports...'
  SimpleCovHelper.merge_all_results!
end