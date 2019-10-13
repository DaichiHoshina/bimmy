# frozen_string_literal: true

class AddCityToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :city, :string
    add_column :posts, :prefecture_id, :integer
  end
end
