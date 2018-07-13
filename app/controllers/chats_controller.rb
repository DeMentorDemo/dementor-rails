class ChatsController < ApplicationController
  before_action :authenticate_request!

  # POST chats/create
  def create
    if Chat.create_chat_with @current_user, params[:user_id].to_i
      head :created
    else
      head :bad_request
    end
  end

end
