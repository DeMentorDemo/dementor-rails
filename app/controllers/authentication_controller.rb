# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!

  # POST /auth/login
  def login
    render Authentication::Login.call params[:email], params[:password]
  end
end
