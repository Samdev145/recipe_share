class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string 	:name
      t.text 		:steps
      t.text 		:ingredients
      t.string 	:cuisine

      t.timestamps
    end
  end
end
