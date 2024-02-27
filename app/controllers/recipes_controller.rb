class RecipesController < ApplicationController

    def index
        # Reads all recipies
        recipes = Recipe.all
        render json: recipes
    end
  
    def create
        # Creates a new recipe
        recipe = Recipe.create(recipe_params)
        render json: recipe
    end
  
    def update
    end
  
    def destroy
    end

    # Handle strong parameters
    private
    def recipe_params
        params.require(:recipe).permit(:title, :subsitution, :ingredients, :servings, :instructions, :image, :cooktime, :fats, :calories, :protiens, :carbs, :sugars, :fibers)
    end
end
