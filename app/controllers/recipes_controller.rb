class RecipesController < ApplicationController

    def index
        # Reads all recipies
        recipes = Recipe.all
        render json: recipes
    end
  
    def create
        # Creates a new recipe
        recipe = Recipe.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: 200
        else 
            puts recipe.errors.inspect # Log errors to console
            render json: recipe.errors, status: 422
        end
    end
    
  
    def update
        recipe = Recipe.find(params[:id])
        recipe.update(recipe_params)
        if recipe.valid?
            render json: recipe
        else
            render json: recipe.errors, status: 422
        end
    end
  
    def destroy
        recipe = Recipe.find(params[:id])
        if recipe.destroy
            render json: recipe
        else 
            render json: recipe.errors, status: 422
        end
    end

    
private
def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :servings, :instructions, :image, :cooktime, :preptime, :totaltime, :fats, :calories, :proteins, :carbs, :sugars, :fibers)
end

end
