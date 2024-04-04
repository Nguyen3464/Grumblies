    class RecipesController < ApplicationController

        before_action :authenticate_user!, only: [:update]

        def index
            @recipes = Recipe.all
            puts @recipes.inspect
            render json: @recipes
        end
    
        def create
            recipe = Recipe.create(recipe_params)
            if recipe.valid?
                render json: recipe, status: 200
            else 
                render json: { errors: recipe.errors }, status: 422
            end
        end
        
        
        def update
            recipe = Recipe.find(params[:id])
            if recipe.user == current_user  # Ensure only the recipe owner can update it
              if recipe.update(recipe_params)
                render json: recipe, status: :ok
              else
                render json: { errors: recipe.errors }, status: :unprocessable_entity
              end
            else
              render json: { error: "You are not authorized to update this recipe" }, status: :unauthorized
            end
          end
        
          def destroy
            recipe = Recipe.find_by(id: params[:id])
            if recipe
              if current_user && recipe.user == current_user  # Ensure current user is authorized to delete the recipe
                if recipe.destroy
                  render json: recipe
                else
                  render json: { errors: recipe.errors }, status: 422
                end
              else
                render json: { error: "You are not authorized to delete this recipe" }, status: :unauthorized
              end
            else
              render json: { error: "Recipe not found" }, status: 404
            end
          end
          
          
          

    
          

        
    private
    def recipe_params
        params.require(:recipe).permit(:title, :ingredients, :servings, :instructions, :image, :cooktime, :preptime, :totaltime, :fats, :calories, :proteins, :carbs, :sugars, :fibers, :description, :user_id)
    end

    end
