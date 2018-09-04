# frozen_string_literal: true

class ChatsController < ApplicationController
  # POST /chats
  def create
    head Chats::CreateWith.call @current_user, params[:user_id].to_i
  end
end
