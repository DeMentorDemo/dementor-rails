class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, presence: true

  def self.create_chat_with(current_user, user_id)
    chat_with = User.find user_id
    name = "#{current_user.name} - #{chat_with.name}"
    chat = new name: name
    chat.users << current_user << chat_with
    chat.save
  end
end
