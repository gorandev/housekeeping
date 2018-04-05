require 'twitter'

class GrabTweetsJob < ApplicationJob
  queue_as :default

  def perform(*args)
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
              :twitterid => tweet.id
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

  include Api::V1::TweetsController::TwitterAuthentication
end
