# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :user_name, :string
    add_column :users, :image_url, :string
    add_column :users, :remember_token, :string
  end
end
