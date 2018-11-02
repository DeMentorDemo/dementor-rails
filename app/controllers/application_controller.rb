# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  attr_reader :current_user

  def authenticate_request!
    @current_user = Authentication::CurrentUser.call request.headers['Authorization']
  rescue Authentication::AuthenticationError => error
    render json: { errors: [error.message] }, status: :unauthorized
  end
end
