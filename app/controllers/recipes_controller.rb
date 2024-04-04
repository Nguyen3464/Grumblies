    class RecipesController < ApplicationController

        # before_action :authenticate_user!, only: [:update]

        def index
            @recipes = Recipe.all
            render json: @recipes
        end
    
        def create
            recipe = Recipe.create(recipe_params)
            if recipe.valid?
              render json: recipe
            else 
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
              render json: { message: "Recipe deleted successfully" }, status: 200
            else 
              render json: { error: "Failed to delete recipe" }, status: 422
            end
          end
          
          
          
          

    
          

        
    private
    def recipe_params
        params.require(:recipe).permit(:title, :ingredients, :servings, :instructions, :image, :cooktime, :preptime, :totaltime, :fats, :calories, :proteins, :carbs, :sugars, :fibers, :description, :user_id)
    end

    end
