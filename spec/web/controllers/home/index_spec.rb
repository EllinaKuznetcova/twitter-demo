require 'spec_helper'
require_relative '../../../../apps/web/controllers/home/index'
require_relative 'tweets_test_helper'
include Warden::Test::Helpers
include Warden::Test::Mock

describe Web::Controllers::Home::Index do
  let(:action) { Web::Controllers::Home::Index.new }
  let(:params) { Hash[] }
  let(:user_repository) { UserRepository.new }
  let(:tweets_test_helper) { TweetsTestHelper.new }

  before do
    @user = user_repository.create({
      nickname: "test",
      twitter_id: 1,
      twitter_access_token: "token",
      twitter_access_secret: "secret"
    })

    login_as @user
    params.merge!({"warden" => warden})
  end

  after { Warden.test_reset! }

  it 'is gets correct user from session'  do
    response = action.call(params)
    action.exposures[:current_user].must_equal @user
  end

  describe 'gets tweets from db' do

    it 'receives same amount' do
      tweets_test_helper.set_tweets(@user)
      response = action.call(params)

      action.exposures[:tweets].count.must_equal tweets_test_helper.tweets_count
    end

    it 'receives reverse ordered tweets' do
      tweets_test_helper.set_tweets(@user)
      response = action.call(params)

      tweets_ids_reversed = tweets_test_helper.tweets.reverse.map{ |tweet| tweet.id }
      action.exposures[:tweets].map{ |tweet| tweet.id }.must_equal tweets_ids_reversed
    end
  end
end
