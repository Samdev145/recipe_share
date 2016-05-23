class AddUserIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :string
    add_index :recipes, :user_id
  end
end
