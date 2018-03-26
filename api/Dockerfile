FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /housekeeping
WORKDIR /housekeeping
COPY Gemfile /housekeeping/Gemfile
COPY Gemfile.lock /housekeeping/Gemfile.lock
RUN env NOKOGIRI_USE_SYSTEM_LIBRARIES=true bundle install
COPY . /housekeeping
