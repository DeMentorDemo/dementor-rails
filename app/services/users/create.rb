# frozen_string_literal: true

module Users
  class Create
    include Callable

    def call
      user = User.new user_params
      if user.save
        { json: { user: user_params }, status: :created }
      else
        { json: { errors: user.errors }, status: :unauthorized }
      end
    end

    private

    attr_reader :user_params

    def initialize(user_params)
      @user_params = user_params
    end
  end
end
