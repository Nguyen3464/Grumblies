class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :ingredients
      t.string :subsitution
      t.text :instructions
      t.string :servings
      t.integer :cooktime
      t.text :image
      t.integer :calories
      t.integer :fats
      t.integer :Carbs
      t.integer :protiens
      t.integer :fibers
      t.integer :sugars

      t.timestamps
    end
  end
end
