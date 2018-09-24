# frozen_string_literal: true

module Authentication
  class Login
    include Callable

    def call
      user = User.find_by email: email
      if user&.authenticate password
        user.sign_in
        { json: token(user) }
      else
        { json: { errors: ['Invalid Username/Password'] }, status: :unauthorized }
      end
    end

    private

    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    EXPIRATION_DAYS = 7

    def token(user)
      return unless user&.id

      exp = EXPIRATION_DAYS.days.from_now.to_i
      { auth_token: JsonWebToken.encode(user_id: user.id, exp: exp) }
    end
  end
end
