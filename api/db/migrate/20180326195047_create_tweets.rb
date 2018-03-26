class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.references :topic, foreign_key: true
      t.string :author
      t.string :body
      t.integer :retweets
      t.integer :favs
      t.datetime :posted_on

      t.timestamps
    end
  end
end
