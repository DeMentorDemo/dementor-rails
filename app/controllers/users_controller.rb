class UsersController < ApplicationController
  def create
    @user = User.new user_params
    if @user.save
      render json: {user: user_params}, status: 200
    else
      render json: {errors: @user.errors}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end