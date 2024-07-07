#!/usr/bin/env bash
docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull
docker-compose -f docker-prod.yml build runner