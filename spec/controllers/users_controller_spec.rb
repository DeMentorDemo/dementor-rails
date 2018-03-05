require 'rails_helper'

describe UsersController, type: :controller do

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'should create new user' do
        users_count = User.count
        user = build(:user)
        post :create, params: {user: {email: user.email,
                                      password: user.password,
                                      password_confirmation: user.password_confirmation}}
        expect(User.count - users_count).to eq(1)
      end
    end
  end
end