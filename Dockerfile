# Multi-stage build to reduce image size for deployment
# pre-build step, which is responsible for building the codebase and compiling assets
FROM  quay.io/evl.ms/fullstaq-ruby:2.7.4-jemalloc-buster-slim AS pre-build

# The following ARGs let us customize the build process.
# `environment` sets the RAILS_ENV
# `without` sets value for `BUNDLE_WITHOUT`, eg. BUNDLE_WITHOUT=development
# `cleanup` sets additional directories that we want to remove after the build process
ARG environment="test"
ARG without
ARG cleanup
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin
ENV environment $environment

RUN echo "Building for $environment..."

RUN apt-get update \
      && apt-get -y install --no-install-recommends tzdata git build-essential\
      && rm -rf /var/lib/apt/lists/*


ENV BUNDLE_WITHOUT=$without

RUN mkdir -p /usr/src/app/lib/order_transformer
# Copy our code base into the image
WORKDIR /usr/src/app

# Enhance layer caching, copy Gemfiles only when they did change. Not when a single file in the repo is changed
COPY Gemfile* /usr/src/app
COPY order_transformer.gemspec /usr/src/app
COPY lib/order_transformer/version.rb /usr/src/app/lib/order_transformer

# Install only new gems, when the Gemfiles did change
RUN gem install bundler

# it's a gem so don't use frozen
RUN bundle install -j4 --retry 3

COPY . .

# Run bundle and yarn with "close to deployment" flags, then remove unnecessary folders in order to
# keep the image size smaller.
# frozen 1: Disallow changes to the Gemfile (ensures Gemfile.lock has to be updated)
RUN   bundle install -j4 --retry 3 \
      && rm -rf /usr/local/bundle/cache/*.gem \
      && find /usr/local/bundle/gems/ -name "*.c" -delete \
      && find /usr/local/bundle/gems/ -name "*.o" -delete

# Final build
# Uses the pre-build image, where the codebase has already been prepared. All the dependencies that we needed
# for the build process are removed, and only the ones we need to run the code are included in this.
FROM  quay.io/evl.ms/fullstaq-ruby:2.7.4-jemalloc-buster-slim
# ARG environment

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

# poppler-utils = pdfunite
RUN apt-get update \
    && apt-get -y install --no-install-recommends tzdata git\
    && rm -rf /var/lib/apt/lists/*git

# so we just copy it to that path in the container
COPY --from=pre-build /usr/src/app /usr/src/app
COPY --from=pre-build /usr/local/bundle/ /usr/local/bundle/

COPY .easyci/wait-for-it.sh /usr/local/bin/wait-for-it.sh

RUN chmod 755 /usr/local/bin/wait-for-it.sh

WORKDIR /usr/src/app
