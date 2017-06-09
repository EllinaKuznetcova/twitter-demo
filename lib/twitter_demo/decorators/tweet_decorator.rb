class TweetDecorator < SimpleDelegator

  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  def published_at
    tweet.published_at.iso8601
  end

  private

    def tweet
      __getobj__
    end
end