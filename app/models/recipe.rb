class Recipe < ApplicationRecord
    belongs_to :user
    validates :title, :ingredients, :servings, :instructions, :image, :cooktime, :preptime, :totaltime, :fats, :calories, :proteins, :carbs, :sugars, :fibers, :description, :user_id, presence: true
  end
  