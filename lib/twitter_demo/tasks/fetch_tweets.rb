require "ostruct"

class FetchTweets
  def perform 
    tweet_repository = TweetRepository.new

    UserRepository.new.all.each do |user|

      last_tweet = tweet_repository.find_last_by_user_id(user.id.to_s) || NullTweet.new(tweet_id: "1")
      
      tweets = TwitterClient.new(
          token: user.twitter_access_token, 
          secret: user.twitter_access_secret
        ).home_timeline(since_id: last_tweet.tweet_id, count: 200)
        .map {|item| {
          tweet_id: item.id.to_s,
          text: item.full_text, 
          author: item.user.name,
          author_image_url: item.user.profile_image_uri.to_s,
          favorite_count: item.favorite_count,
          published_at: item.created_at.to_s
        }}
      tweets.each do |tweet|
        tweet_repository.create_if_needed(tweet.merge(user_id: user.id.to_s))
      end
    end
  end

  private

    class NullTweet < OpenStruct; end
end