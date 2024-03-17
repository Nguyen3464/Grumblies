class RemoveSubstitutionFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :subsitution, :string
  end
end
