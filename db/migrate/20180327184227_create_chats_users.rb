class CreateChatsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :chats_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :chat
    end
  end
end
