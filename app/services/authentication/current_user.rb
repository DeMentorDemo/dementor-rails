# frozen_string_literal: true

module Authentication
  class CurrentUser
    include Callable

    def call
      return User.find(auth_token[:user_id]) if user_id_in_token?

      raise AuthenticationError, 'Not Authenticated'
    rescue JWT::ExpiredSignature
      raise AuthenticationError, 'Auth token has expired'
    rescue JWT::VerificationError, JWT::DecodeError
      raise AuthenticationError, 'JWT Token is Broken'
    end

    private

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def http_token
      @http_token ||= token&.split(' ')&.last
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end

    def user_id_in_token?
      http_token && auth_token && auth_token[:user_id]
    end
  end
end
