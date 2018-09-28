# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :email, :first_name, :last_name, :created_at
  attribute :avatar do |user, params|
    params ? params[:avatar_url].call(user.avatar) : nil
  end
end
