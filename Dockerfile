FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /task-manager-api

WORKDIR /task-manager-api

COPY Gemfile /task-manager-api/Gemfile
COPY Gemfile.lock /task-manager-api/Gemfile.lock

RUN bundle install

COPY . /task-manager-api
