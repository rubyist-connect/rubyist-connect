FROM ruby:2.5.1
ENV LANG C.UTF-8
LABEL maintainer 'Yuji Shimoda <yuji.shimoda@gmail.com>'

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs chromedriver
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
ENV DATABASE_HOST db