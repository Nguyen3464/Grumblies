class ChangeServingsAndCooktimeToStringInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :servings, :string
    change_column :recipes, :cooktime, :string
  end
end
