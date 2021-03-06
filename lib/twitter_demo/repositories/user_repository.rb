class UserRepository < Hanami::Repository
  def find_by_twitter_id(twitter_id)
    users.where(twitter_id: twitter_id).first
  end

  def from_omniauth(omniauth)
    twitter_id = omniauth.uid
    found = find_by_twitter_id(twitter_id)

    attrs = {}
    attrs[:name] = omniauth.info.name
    attrs[:nickname] = omniauth.info.nickname
      attrs[:image] = omniauth.info.image
    attrs[:twitter_access_token] = omniauth.credentials.token
    attrs[:twitter_access_secret] = omniauth.credentials.secret
    
    if found
      UserRepository.new.update(found.id,attrs)
    else
      UserRepository.new.create(attrs.merge(twitter_id: twitter_id))
    end
  end
end
