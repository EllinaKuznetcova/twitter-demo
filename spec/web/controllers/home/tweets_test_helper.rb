class TweetsTestHelper

  attr_reader :tweets
  attr_reader :tweets_count

  def set_tweets(user)
    @tweets_count = 10
    tweet_repository = TweetRepository.new
    @tweets = Array[]

    (1..@tweets_count).each do |counter|
      @tweets << tweet_repository.create({
        tweet_id: counter.to_s,
        user_id: user.id.to_s,
        text: "text",
        author: "author",
        author_image_url: "url",
        favorite_count: 10,
        published_at: DateTime.now
      })
    end
  end
end