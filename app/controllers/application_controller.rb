# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  def authenticate_request!
    if !user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    else
      @current_user = User.find(auth_token[:user_id])
    end
  rescue JWT::ExpiredSignature
    render json: { errors: ['Auth token has expired'] }, status: :unauthorized
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['JWT Token is Broken'] }, status: :unauthorized
  end

  private

  def http_token
    token = request.headers['Authorization']
    @http_token ||= token&.split(' ')&.last
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end
end
