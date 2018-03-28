FactoryBot.define do
  factory :topic do
    querytext { Forgery::LoremIpsum.characters((rand*10).to_i + 1) }
  end

  factory :tweet do
    topic
    author { Forgery::Name.full_name }
    body { Forgery::LoremIpsum.characters((rand*120).to_i + 1) }
    retweets { (rand*1200).to_i + 125 }
    favs { (rand*200).to_i + 50 }
    posted_on { Forgery::Date.date }
    twitterid { (rand*892109) + 98492 }
  end
end
