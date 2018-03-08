class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:show]

  def create
    @user = User.new user_params
    if @user.save
      render json: {user: user_params}, status: 200
    else
      render json: {errors: @user.errors}, status: :unauthorized
    end
  end

  def show
    render json: @current_user.to_json
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end