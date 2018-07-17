# frozen_string_literal: true

require 'rails_helper'

describe 'Chats', type: :request do
  let(:current_user) { create :user }
  let(:chat_with_user) { create :user }
  let(:valid_token) do
    exp = 7.days.from_now.to_i
    JsonWebToken.encode(user_id: current_user.id, exp: exp)
  end

  describe 'POST chats' do
    context 'with valid attributes' do
      it 'should create new chat' do
        post '/chats', params: { user_id: chat_with_user.id }, headers: { Authorization: valid_token }
        expect(response).to be_created
      end
    end
  end
end
