# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/session', to: 'session#failure'
get "/auth/:provider/callback", to: 'session#new'
get '/', to: 'home#index', as: :root
