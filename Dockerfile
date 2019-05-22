FROM ruby:2.6.3-alpine3.9
ENV HOME="/usr/src/mongo_customer_steps_sample" \
  TZ="Asia/Tokyo"
WORKDIR ${HOME}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual .build-deps \
      libxml2-dev \
      curl-dev \
      make \
      gcc \
      libc-dev \
      g++ \
      tzdata \
      mariadb-dev \
      git && \
    apk add --no-cache --virtual .dev-tools \
      bash && \
    apk add --no-cache \
      nodejs && \
    gem install bundler

COPY Gemfile Gemfile.lock ./

RUN bundle

CMD [ "rails", "s", "-b", "0.0.0.0" ]
