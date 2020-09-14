FROM ruby:2.7

RUN apt-get update -qq

RUN mkdir /app
WORKDIR /app

COPY . /app

RUN gem install bundler:1.17.3

RUN bundle install
