module Web::Controllers::Home
  class Index
    include Web::Action

    expose :current_user
    expose :tweets

    def call(params)
      @current_user ||= warden.user
      get_tweets
    end

    def warden
      request.env["warden"]
    end

    def get_tweets
      if @current_user
        @tweets = TweetDecorator.wrap(TweetRepository.new.find_by_user(@current_user))
      else
        nil
      end
    end
  end
end
