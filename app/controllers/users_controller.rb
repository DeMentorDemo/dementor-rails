# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_request!, except: [:create]

  # GET users
  def index
    render json: User.contacts(@current_user).to_json, status: :ok
  end

  # POST users/signup
  def create
    @user = User.new user_params
    if @user.save
      render json: { user: user_params }, status: :created
    else
      render json: { errors: @user.errors }, status: :unauthorized
    end
  end

  # GET users/current_user
  def current_user
    render json: @current_user.to_json
  end

  # GET /users/show/:id
  def show
    render json: User.find(params[:id].to_i).to_json
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
