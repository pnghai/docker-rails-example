ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-bookworm AS assets
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"

WORKDIR /app

ARG NODE_MAJOR
ARG UID=1000
ARG GID=1000

ENV YARN_CACHE_FOLDER /yarn
RUN bash -c "set -eo pipefail && apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl git libpq-dev libvips pkg-config\
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key -o /etc/apt/keyrings/nodesource.asc \
  && echo 'deb [signed-by=/etc/apt/keyrings/nodesource.asc] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main' | tee /etc/apt/sources.list.d/nodesource.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs \
  && corepack enable \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && groupadd -g \"${GID}\" ruby \
  && useradd --create-home --no-log-init -u \"${UID}\" -g \"${GID}\" ruby \
  && mkdir /node_modules \
  && mkdir $YARN_CACHE_FOLDER && chown ruby:ruby /node_modules /app -R $YARN_CACHE_FOLDER"
USER ruby

COPY --chown=ruby:ruby Gemfile* ./

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
# Uncomment this line if you store Bundler settings in the project's root
# ENV BUNDLE_APP_CONFIG=.bundle

RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY --chown=ruby:ruby ../package.json *yarn* ./
RUN yarn config set cache-folder $YARN_CACHE_FOLDER && yarn install --frozen-lockfile
#https://dev.to/otomato_io/how-to-optimize-production-docker-images-running-nodejs-with-yarn-504b

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
    USER="ruby"

COPY --chown=ruby:ruby .. .
# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

RUN if [ "${RAILS_ENV}" != "development" ]; then \
  SECRET_KEY_BASE_DUMMY=1 rails assets:precompile; fi

CMD ["bash"]

###############################################################################
ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-bookworm AS app
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"
ARG PG_MAJOR

WORKDIR /app

ARG UID=1000
ARG GID=1000
# Set environment variables to reduce output from debconf
ENV DEBIAN_FRONTEND=noninteractive

RUN bash -c "set -oe pipefail && apt-get update -yq \
  && apt-get install -y --no-install-recommends build-essential \
    libxext6 \
    libjpeg62-turbo-dev \
    libssl1.0 \
    libpq-dev \
    libvips42 \
    gnupg2 \
    wget \
    git \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql.gpg \
  && echo \"deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main\" > /etc/apt/sources.list.d/pgdg.list \
  && apt-get update && apt-get install -y --no-install-recommends postgresql-client-$PG_MAJOR \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && truncate -s 0 /var/log/*log \
  && groupadd -g \"${GID}\" ruby \
  && useradd --create-home --no-log-init -u \"${UID}\" -g \"${GID}\" ruby \
  && chown ruby:ruby -R /app"

USER ruby

COPY --chown=ruby:ruby ../bin ./bin
RUN chmod 0755 bin/*
# Uncomment this line if you want to run binstubs without prefixing with `bin/` or `bundle exec`
# ENV PATH /app/bin:$PATH

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby --from=assets /usr/local/bundle /usr/local/bundle
COPY --chown=ruby:ruby --from=assets /app/public /public
COPY --chown=ruby:ruby .. .

ENTRYPOINT ["/app/bin/docker-entrypoint-web"]

CMD ["rails", "s"]
#"rm", "-f", "tmp/pids/server.pid", "&&",
