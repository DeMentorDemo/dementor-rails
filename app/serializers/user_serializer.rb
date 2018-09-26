# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :email, :first_name, :last_name, :created_at
  attribute :avatar do |_user, params|
    params ? params[:avatar_url] : nil
  end
end
