# frozen_string_literal: true

class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :post_id

      t.timestamps
    end
  end
end
