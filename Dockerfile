FROM ruby:2.6.3

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs\
  mysql-server\
  mysql-client

WORKDIR /SpotMemory_App

COPY Gemfile /SpotMemory_App/Gemfile
COPY Gemfile.lock /SpotMemory_App/Gemfile.lock

RUN gem install bundler
RUN bundle install

RUN mkdir -p tmp/sockets