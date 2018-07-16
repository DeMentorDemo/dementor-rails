# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  attr_reader :current_user

  def authenticate_request!
    if user_id_in_token?
      @current_user = User.find(auth_token[:user_id])
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  rescue JWT::ExpiredSignature
    render json: { errors: ['Auth token has expired'] }, status: :unauthorized
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['JWT Token is Broken'] }, status: :unauthorized
  end

  def http_token
    @http_token ||= request.headers['Authorization']&.split(' ')&.last
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end
end
