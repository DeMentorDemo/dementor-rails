# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    render Authentication::Login.call params[:email], params[:password]
  end
end
