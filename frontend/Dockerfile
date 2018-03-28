FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential ruby-full
RUN gem install sinatra thin haml
RUN mkdir /housekeeping
WORKDIR /housekeeping
COPY . /housekeeping
