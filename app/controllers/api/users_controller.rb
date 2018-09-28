# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :authenticate_request!, only: [:create]

    # GET /users
    def index
      users = User.with_attached_avatar.contacts(current_user)
      render json: UserSerializer.new(users, avatar_url).serialized_json, status: :ok
    end

    # POST /users
    def create
      render Users::Create.call user_params
    end

    # PUT /users
    def update
      user = User.find params[:id].to_i
      # user.update_attributes user_params
      user.avatar.attach(params[:image]) if params[:image]
      head :ok
    end

    # GET /users/:id
    def show
      user = User.find params[:id].to_i
      render json: UserSerializer.new(user, avatar_url).serialized_json
    end

    # GET /current_user
    def current
      render json: UserSerializer.new(current_user, avatar_url).serialized_json
    end

    private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end

    def avatar_url
      url_callback = ->(attachment) { attachment.attached? ? url_for(attachment) : nil }
      { params: { avatar_url: url_callback } }
    end
  end
end
