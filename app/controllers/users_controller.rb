# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_request!, except: [:create]

  # GET /users
  def index
    users = User.contacts(@current_user)
    render json: UserSerializer.new(users).serialized_json, status: :ok
  end

  # POST /users
  def create
    render Users::Create.call user_params
  end

  # GET /users/:id
  def show
    render json: User.find(params[:id].to_i).to_json
  end

  # GET /current_user
  def current_user
    render json: @current_user.to_json
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
