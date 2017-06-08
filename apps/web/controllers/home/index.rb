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
        @tweets = TwitterClient.new(
          token: @current_user.twitter_access_token, 
          secret: @current_user.twitter_access_secret
        ).home_timeline
        .map {|item| {
          full_text: item.full_text, 
          name: item.user.name,
          favorite_count: item.favorite_count,
          user_image_url: item.user.profile_image_uri.to_s,
          created_at: item.created_at.to_s
        }}
      else
        nil
      end
    end
  end
end
