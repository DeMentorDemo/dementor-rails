# frozen_string_literal: true

class ChatSerializer < ApplicationSerializer
  attributes :name
  has_many :users

  has_many :messages, if: ->(_record, params) { params && params[:show_messages] }
end
