require 'spec_helper'
require_relative '../../../../apps/web/controllers/session/new'

describe Web::Controllers::Session::New do
  let(:action) { Web::Controllers::Session::New.new }
  let(:params) { Hash[] }
  let(:info) { {name: "name", nickname: "nickname", image: "image_link"} }
  let(:credentials) { {token: "token", secret: "secret"} }
  let(:user_repository) { UserRepository.new }

  before do
    omniauth = OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '123545',
      :info => info,
      :credentials => credentials
    })

    user_repository.clear

    params.merge!({"omniauth.auth" => omniauth})
    params.merge!({"warden" => warden})
  end

  describe 'when logged in from twitter' do
    it 'saves user' do
      action.call(params)
      user = user_repository.last

      user.id.wont_be_nil
      
      user.name.must_equal info[:name]
      user.nickname.must_equal info[:nickname]
      user.image.must_equal info[:image]

      user.twitter_access_token.must_equal credentials[:token]
      user.twitter_access_secret.must_equal credentials[:secret]
    end

    it 'redirects to main page' do
      response = action.call(params)
      
      response[0].must_equal 302
      response[1]['Location'].must_equal Web.routes.path(:root)
    end
  end
end
