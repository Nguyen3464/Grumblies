class ChangeCarbsToLowerCaseInRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes, :Carbs, :carbs
  end
end
