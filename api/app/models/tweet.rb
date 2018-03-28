class Tweet < ApplicationRecord
  belongs_to :topic

  def as_json(*)
    {
      topic: topic.querytext,
      author: author,
      body: body,
      retweets: retweets,
      favs: favs,
      posted_on: posted_on,
      twitterid: twitterid
    }
  end
end
