# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :validatable

  has_many :messages
  has_and_belongs_to_many :chats

  validates_presence_of :first_name, :last_name

  scope :contacts, ->(user) { where.not(id: user.id) }

  def name
    "#{first_name} #{last_name}"
  end

  def sign_in
    self.sign_in_count += 1
    self.last_sign_in_at = current_sign_in_at
    self.current_sign_in_at = Time.now
    save
  end
end
