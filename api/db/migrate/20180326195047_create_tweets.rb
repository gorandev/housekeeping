class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.references :topic, foreign_key: true
      t.string :author
      t.string :body
      t.integer :retweets
      t.integer :favs
      t.datetime :posted_on
      t.integer :twitter_id, :limit => 8

      t.timestamps
    end
    add_index :tweets, :twitter_id, unique: true
  end
end
