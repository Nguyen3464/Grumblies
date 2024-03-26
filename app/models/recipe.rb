class Recipe < ApplicationRecord
    validates :title, :ingredients, :servings, :instructions, :image, :cooktime, :preptime, :totaltime, :fats, :calories, :proteins, :carbs, :sugars, :fibers, presence: true
  end
  