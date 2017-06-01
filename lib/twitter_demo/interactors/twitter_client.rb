class TwitterClient
  def initialize(options = {})
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "5Ka9O3vGVCnxmHOK67gc61Bpi"
      config.consumer_secret     = "RoWRc0pG3q0UJ88kHN69sRGw44M06EaHOuUhLvR8BLojz2uQls"
      config.access_token        = options[:token]
      config.access_token_secret = options[:secret]
    end
  end

  def method_missing(method, *args, &block)
    @client.public_send(method)
  end
end