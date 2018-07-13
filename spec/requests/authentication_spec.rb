# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  let(:user) { create :user }

  describe 'POST /auth/login' do
    context 'with valid attributes' do
      it 'should return jwt token' do
        post '/auth/login', params: { email: user.email, password: user.password }
        payload = JsonWebToken.decode(json['auth_token'])
        expect(response).to be_success
        expect(payload).to have_key('user_id')
        expect(payload).to have_key('exp')
      end
    end

    context 'with invalid attributes' do
      it 'should return auth error' do
        post '/auth/login', params: { email: user.email, password: "#{user.password}spoil" }
        expect(response).to be_unauthorized
        expect(json).to have_key('errors')
      end
    end
  end
end
