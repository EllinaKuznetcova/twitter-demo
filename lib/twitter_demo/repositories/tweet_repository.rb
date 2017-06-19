class TweetRepository < Hanami::Repository
  def find_by_user(user, limit = 20)
  tweets.where(user_id: user.id.to_s)
    .order(:published_at)
    .reverse
    .limit(limit)
  end
  
  def find_last_by_user_id(user_id)
    tweets.where(user_id: user_id)
    .order(:published_at)
    .reverse
    .first
  end

  def find_by_tweet_and_user(tweet)
    tweets.where(tweet_id: tweet[:tweet_id], user_id: tweet[:user_id]).first
  end
  
  def create_if_needed(tweet)
    find_by_tweet_and_user(tweet) || create(tweet)
  end
end