class RenameProtiensToProteinsInRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes, :protiens, :proteins
  end
end
