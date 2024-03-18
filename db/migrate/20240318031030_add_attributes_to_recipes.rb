class AddAttributesToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :totaltime, :string
    add_column :recipes, :preptime, :string
  end
end
