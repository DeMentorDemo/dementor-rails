# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = Authentication::CurrentUser.call request.params['Authorization']
    rescue Authentication::AuthenticationError
      reject_unauthorized_connection
    end
  end
end
