# Credit goes to https://gitlab.com/gitlab-org/gitlab-foss/blob/master/spec/simplecov_env.rb

require "simplecov"
require "active_support"
require "active_support/core_ext/numeric/time"

SimpleCov.profiles.define :marty do
  enable_coverage ENV.fetch("COVERAGE_METHOD", "line").to_sym

  track_files "{app,config,lib,spec}/**/*.rb"

  add_filter "db/migrate"
  add_filter "vendor/"
  # add_filter "extjs/"

  add_group "Channels", "app/channels"
  add_group "Controllers", "app/controllers"
  add_group "Helpers", "app/helpers"
  add_group "Jobs", ["app/jobs", "app/workers"]
  add_group "Mailers", "app/mailers"
  add_group "Models", "app/models"
  add_group "Services", "app/services"
  add_group "Configs", "config/"
  add_group "Libraries", "lib/"
  add_group "Specs", "spec/"

  use_merging true
  merge_timeout 1.day
  if ENV["GITLAB_CI"]
    job_name = ENV.fetch("CI_JOB_NAME", nil)
    coverage_dir "coverage/#{job_name}"
    command_name job_name
    SimpleCov.at_exit { SimpleCov.result }
  end
end

module SimpleCovHelper
  def self.merge_all_results!
    # Collate and combine all the previous coverage results that we produced
    # in other RSpec runs. Combine them using the custom profile we created.
    # This method also handles storing them for you
    SimpleCov.collate(Dir["coverage/**/.resultset.json"], :marty)

    # Singleton responsible for keeping track of the last merged result in
    # memory
    merged_result = SimpleCov::ResultMerger.merged_result

    # Print out to console all the groups and their percents + hits/line.
    groups = merged_result.groups.map do |group, files|
      [group, files.covered_percent, files.covered_strength]
    end

    # Sort by percentage and print everything
    sorted_groups = groups.sort_by { |_gr, per, _str| -per }
    sorted_groups.each do |group|
      gr_name, percent, strength = group
      LOGGER.info(
        "Group '#{gr_name}': #{percent} covered at #{strength} hits/line",
        )
    end

    merged_result.format!
  end
  def self.start!
    return unless ENV["COVERAGE"] == "true"

    SimpleCov.start :marty
  end
end