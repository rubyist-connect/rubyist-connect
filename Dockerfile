FROM ruby:3.0.0
ENV LANG C.UTF-8
LABEL maintainer 'Yuji Shimoda <yuji.shimoda@gmail.com>'

# https://github.com/nodesource/distributions#installation-instructions
RUN apt-get update -qq && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y build-essential libpq-dev nodejs ./google-chrome-stable_current_amd64.deb && \
    gem install bundler -v 2.1.4
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
ENV DATABASE_HOST db
ENV DATABASE_USERNAME postgres
