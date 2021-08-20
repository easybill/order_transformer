#!/usr/bin/env bash

# This script is called via http://ci2.easybill.io:8000/github_webhook?task_type=unittests
# where task_type = easyci_<task_type>.sh
# important ... github webhook needs to send the request via 'application/json'
#
#

set -x
set -o pipefail

log () {
  printf '[%s] %s\n' "$(date)" "$1"
}

log "Starting test job"
log ""
log "Shutting down old running containers ..."

touch .env-docker

pwd
ls -ltra

docker-compose down --remove-orphans  -v 2>/dev/null

rm -rf "log/*" "tmp/*" 2>/dev/null

docker-compose version

cat <<End-of-message > .env-docker
IM_BUILD_ENV=test
End-of-message

log ""
log "Start containers ..."

docker-compose --env-file .env-docker build --parallel

docker-compose --env-file .env-docker up --detach

DC_EXEC_RUBY_CONT="docker-compose --env-file .env-docker run --rm ruby "

log ""
log "Run tests and pretyfier ..."

timeout 1600 $DC_EXEC_RUBY_CONT bash -c "bundle exec rake spec 2>&1|tee -a stdout.log && bundle exec rake standard && bundle audit --update "
RET=$?

log ""
log ""

# docker-compose logs
docker-compose down --remove-orphans  -v

log ""
log "Job-Result: $RET"

exit $RET
