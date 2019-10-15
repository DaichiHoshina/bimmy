class AddRateToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rate, :float
  end
end
