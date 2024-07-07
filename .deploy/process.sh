#!/usr/bin/env bash
git pull
docker-compose -f docker-prod.yml run --rm runner  bundle install -j4 --without development test
docker-compose -f docker-prod.yml run --rm runner yarn install
#docker-compose -f docker-prod.yml run --rm runner yarn build
docker-compose -f docker-prod.yml run --rm runner bundle exec rake assets:precompile
docker-compose -f docker-prod.yml run --rm runner bundle exec rake assets:clean
docker-compose -f docker-prod.yml run --rm runner rails db:migrate
#docker-compose -f docker-prod.yml run --rm runner rake effective_email_templates:import
#rake effective_email_templates:overwrite
# continous deployment
docker-compose -f docker-prod.yml stop && docker-compose -f docker-prod.yml up -d rails sidekiq nginx
#!/bin/bash
CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
#CHATID="-538016621"
#KEY="627093717:AAH-MgjmZ9rY27SgrR_3bpPOYbkHWP2zd9o"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
LAST_5=$(git log --format="%h %B" --oneline -n 5)
APP_URL=$(grep  APP_URL .env | cut -d '=' -f2)
#TEXT="Deployed branch $CURRENT_BRANCH to $APP_URL with last 5 commits: $LAST_5"
#curl -s --max-time ${TIME} -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT" ${URL} >/dev/null
