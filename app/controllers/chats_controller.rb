# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authenticate_request!

  # POST chats/create
  def create
    head Chats::CreateChatWith.call @current_user, params[:user_id].to_i
  end
end
