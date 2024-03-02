class Recipe < ApplicationRecord
    validates :title, :ingredients, :servings, :instructions, :image, :cooktime, :fats, :calories, :protiens, :carbs, :sugars, :fibers, presence: true
end
