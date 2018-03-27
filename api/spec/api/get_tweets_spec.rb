require 'date'
require 'rails_helper'

RSpec.describe "GET tweets for an existing topic", :type => :request do
  before(:each) do
    topic = create(:topic, :querytext => 'boardgames')
    @tweets = [
      {
        :topic => topic,
        :author => '@reinerknizia',
        :body => 'What a great game',
        :retweets => 202,
        :favs => 58,
        :posted_on => DateTime.new(2018,3,15,12,25)
      },
      {
        :topic => topic,
        :author => '@uwerosemberg',
        :body => 'Check out my stuff',
        :retweets => 467,
        :favs => 89,
        :posted_on => DateTime.new(2018,3,14,10,05)
      }
    ]
    @tweets.each do |t|
      create(:tweet, t)
    end
  end

  it "searches about boardgames" do
    expected = @tweets.map do |t|
      t.merge!(
        {
          :topic => t[:topic][:querytext],
          :posted_on => t[:posted_on].to_s.gsub(/\+00:00/,'.000Z')
        }
      )
    end.sort_by do |t|
      t[:posted_on]
    end.to_json

    get '/api/v1/tweets?topic=boardgames'
    expect(response.body).to eq(expected)
  end
end

RSpec.describe "GET tweets for a non-existing topic", :type => :request do
  it "searches about beanie babies" do
    get '/api/v1/tweets?=beanie+babies'
    expect(response).to have_http_status(204)
  end
end
