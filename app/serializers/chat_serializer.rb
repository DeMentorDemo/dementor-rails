# frozen_string_literal: true

class ChatSerializer < ApplicationSerializer
  attributes :name
  has_many :users
end
