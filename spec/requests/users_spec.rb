# frozen_string_literal: true

require 'rails_helper'

describe 'Users', type: :request do
  let(:user) { build :user }
  let(:saved_user) { create :user }
  let(:valid_token) do
    exp = 7.days.from_now.to_i
    JsonWebToken.encode(user_id: saved_user.id, exp: exp)
  end

  describe 'POST /users' do
    context 'with valid attributes' do
      it 'should create new user' do
        users_count = User.count
        post '/api/users', params: { user: { email: user.email,
                                             first_name: user.first_name,
                                             last_name: user.last_name,
                                             password: user.password,
                                             password_confirmation: user.password_confirmation } }
        expect(response).to be_created
        expect(User.count - users_count).to eq(1)
      end
    end
  end

  describe 'GET /current_user' do
    context 'with valid attributes' do
      it 'should return current user from session' do
        get '/api/current_user', params: {}, headers: { Authorization: valid_token }
        data = json['data']
        attributes = data['attributes']
        expect(response).to be_successful
        expect(data).to have_key('id')
        expect(attributes).to have_key('email')
        expect(attributes).to have_key('firstName')
        expect(attributes).to have_key('lastName')
        expect(attributes).to have_key('createdAt')
      end
    end

    context 'with invalid attributes' do
      it 'should return Unauthorized error' do
        get '/api/current_user'
        expect(response).to be_unauthorized
        expect(json).to have_key('errors')
      end

      it 'should return expired token error' do
        exp = (Time.now - 1.day).to_i
        token = JsonWebToken.encode(user_id: saved_user.id, exp: exp)
        get '/api/current_user', params: {}, headers: { Authorization: token }
        expect(response).to be_unauthorized
        expect(json).to have_key('errors')
        expect(json['errors'].to_s).to match(/Auth token has expired/)
      end

      it 'should return expired token error' do
        get '/api/current_user', params: {}, headers: { Authorization: "#{valid_token}broken" }
        expect(response).to be_unauthorized
        expect(json).to have_key('errors')
        expect(json['errors'].to_s).to match(/JWT Token is Broken/)
      end
    end
  end

  describe 'GET /users/show' do
  end

  describe 'GET /users' do
    it 'should return all users except logged in' do
      get '/api/users', params: {}, headers: { Authorization: valid_token }
      expect(response).to be_successful
    end
  end
end
