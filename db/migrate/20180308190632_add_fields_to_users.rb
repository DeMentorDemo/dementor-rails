# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''

    add_index :users, :first_name
    add_index :users, :last_name
  end
end
