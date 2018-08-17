# frozen_string_literal: true

class ChangeUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
      t.string :password_digest
    end
  end
end
