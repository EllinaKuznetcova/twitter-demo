module Web::Controllers::Home
  class Index
    include Web::Action

    expose :current_user

    def call(params)
      @current_user ||= warden.user
    end

    def warden
      request.env["warden"]
    end
  end
end
