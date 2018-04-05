require 'rails_helper'

RSpec.describe "POST a tweet", :type => :request do
  it "exists and accepts a non-blank body, retuns 204" do
    post '/api/v1/tweets', params: { body: 'This is a tweet!' }, as: :json
    expect(response).to have_http_status(204)
  end

  it "returns 400 with a blank body" do
    post '/api/v1/tweets'
    expect(response).to have_http_status(400)
  end

  it "with a non-blank body it tries to send the tweet" do
    client = double("Tweet Client")
    tweet_body = 'This is a tweet!'
    expect_any_instance_of(Api::V1::TweetsController).to receive(:client).and_return(client)
    expect(client).to receive(:update).with(tweet_body)
    post '/api/v1/tweets', params: { body: tweet_body }, as: :json
  end
end
