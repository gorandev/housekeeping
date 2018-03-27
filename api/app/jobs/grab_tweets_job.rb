require 'twitter'

class GrabTweetsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch('TWITTER_CONSUMER_KEY')
      config.consumer_secret     = ENV.fetch('TWITTER_CONSUMER_SECRET')
      config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN')
      config.access_token_secret = ENV.fetch('TWITTER_ACCESS_SECRET')
    end

    begin
      Topic.all.each do |t|
        client.search(t.querytext).take(10).collect do |tweet|
          begin
            Tweet.create!(
              :topic => t,
              :author => tweet.user.screen_name,
              :body => tweet.full_text,
              :retweets => tweet.retweet_count,
              :favs => tweet.favorite_count,
              :posted_on => tweet.created_at,
              :twitter_id => tweet.id
            )
          rescue ActiveRecord::RecordNotUnique
            # tweet already exists
          end
        end
      end
    ensure
      GrabTweetsJob.set(wait: 1.minute).perform_later
    end
  end
end
