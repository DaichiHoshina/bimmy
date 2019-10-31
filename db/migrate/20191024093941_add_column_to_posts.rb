# frozen_string_literal: true

class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :store, :string
  end
end
