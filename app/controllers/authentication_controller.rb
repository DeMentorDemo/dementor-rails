class AuthenticationController < ApplicationController

  # POST /auth/login
  def login
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      user.sign_in
      render json: token(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private
  EXPIRATION_DAYS = 7

  def token(user)
    if user&.id
      exp = EXPIRATION_DAYS.days.from_now.to_i
      {auth_token: JsonWebToken.encode({user_id: user.id, exp: exp})}
    else
      nil
    end
  end
end