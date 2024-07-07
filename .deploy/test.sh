#!/usr/bin/env bash
export $(grep -v '^#' .env.test | xargs -d '\n')
bundle exec rails db:environment:set RAILS_ENV=test db:reset effective_email_templates:import
AUTODOC=$AUTODOC RAILS_ENV=test bundle exec rspec
#