class ChangeNutritionalValuesToStringInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :calories, :string
    change_column :recipes, :fats, :string
    change_column :recipes, :Carbs, :string
    change_column :recipes, :protiens, :string
    change_column :recipes, :fibers, :string
    change_column :recipes, :sugars, :string
  end
end
