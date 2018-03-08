class AuthenticationController < ApplicationController
  def login
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      user.sign_in_count += 1
      user.last_sign_in_at = user.current_sign_in_at
      user.current_sign_in_at = Time.now
      if user.save
        render json: payload(user)
      else
        render json: {errors: user.errors}, status: :unauthorized
      end
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private
  EXPIRATION_DAYS = 7

  def payload(user)
    if user&.id
      exp = EXPIRATION_DAYS.days.from_now.to_i
      {auth_token: JsonWebToken.encode({user_id: user.id, exp: exp})}
    else
      nil
    end
  end
end