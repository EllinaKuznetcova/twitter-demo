module Web::Controllers::Home
  class Index
    include Web::Action
    include Hanami::Pagination::Action

    expose :current_user
    expose :tweets
    expose :all_pages
    expose :current_page

    def call(params)
      @current_user ||= warden.user
      
      get_tweets
      set_pages
    end

    def warden
      request.env["warden"]
    end

    def get_tweets
      if @current_user
        tweets_for_current_page = all_for_page(TweetRepository.new.find_by_user(@current_user))
        @tweets = TweetDecorator.wrap(tweets_for_current_page)
      else
        nil
      end
    end

    def set_pages
      if @current_user
        @all_pages = pager.all_pages
        @current_page = params[:page].to_i
      end
    end
  end
end
