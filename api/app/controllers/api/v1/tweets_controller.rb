class Api::V1::TweetsController < ApplicationController
  module TwitterAuthentication
    def client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV.fetch('TWITTER_CONSUMER_KEY')
        config.consumer_secret     = ENV.fetch('TWITTER_CONSUMER_SECRET')
        config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN')
        config.access_token_secret = ENV.fetch('TWITTER_ACCESS_SECRET')
      end
    end
  end

  def show
    topic = Topic.find_by_querytext(params[:topic])
    unless topic
      head :no_content and return
    end

    render json: Tweet.eager_load(:topic).where(:topic => topic).order(posted_on: :desc).limit(10)
  end

  def post
    unless params[:body]
      head :bad_request and return
    end

    client.update(params[:body])
  end

  include TwitterAuthentication
end
