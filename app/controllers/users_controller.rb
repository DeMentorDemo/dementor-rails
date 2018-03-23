class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:index, :show]

  # GET users
  def index
    render json: User.contacts(@current_user).to_json, status: :ok
  end

  # POST users/signup
  def create
    @user = User.new user_params
    if @user.save
      render json: {user: user_params}, status: :created
    else
      render json: {errors: @user.errors}, status: :unauthorized
    end
  end

  # GET /users/show
  def show
    if params[:id]
      render json: User.find(params[:id].to_i).to_json
    else
      render json: @current_user.to_json
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end