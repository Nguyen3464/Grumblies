require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    it "gets a list of recipies" do
      Recipe.create(
        title: "Bruger",
        subsitution: "chicken",
        ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
        servings: '1',
        instructions: 'cook to medium',
        image: 'url',
        cooktime: '7 Minute',
        fats: '15g',
        calories: '450',
        protiens: '50g',
        carbs: '35g',
        sugars: '7g',
        fibers: '10g'
      )

      # Make a request
      get '/recipes'

      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe.length).to eq 1

    end
  end

  describe "POST /create" do
    it "creates a recipe" do
      recipe_params = {
        recipe: {
          title: "Burger",
          subsitution: "chicken",
          ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
          servings: '1',
          instructions: 'cook to medium',
          image: 'url',
          cooktime: '7 Minute',
          fats: '15g',
          calories: '450',
          protiens: '50g',
          carbs: '35g',
          sugars: '7g',
          fibers: '10g'
        }
      }

      # Send the request to the server
      post '/recipes', params: recipe_params

      # Assure that we get a success back
      expect(response).to have_http_status(200)

      # Look up the recipe we expect to be created in the db
      recipe = Recipe.first

      expect(recipe.title).to eq "Burger"
      expect(recipe.subsitution).to eq "chicken"
      expect(recipe.ingredients).to eq 'Beef, Bun, Lettuce, Tomato, Cheese'
      expect(recipe.servings).to eq '1'
      expect(recipe.instructions).to eq 'cook to medium'
      expect(recipe.image).to eq 'url'
      expect(recipe.cooktime).to eq '7 Minute'
      expect(recipe.fats).to eq '15g'
      expect(recipe.calories).to eq '450'
      expect(recipe.protiens).to eq '50g'
      expect(recipe.carbs).to eq '35g'
      expect(recipe.sugars).to eq '7g'
      expect(recipe.fibers).to eq '10g'

    end
  end


  # describe "Cannot create a recipe without valid attributes" do
  #   it 'cannot create a recipe without a valid title' do
  #     recipe_params = {
  #       recipe: { 
  #       subsitution: "chicken",
  #       ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
  #       servings: '1',
  #       instructions: 'cook to medium',
  #       image: 'url',
  #       cooktime: '7 Minute',
  #       fats: '15g',
  #       calories: '450',
  #       protiens: '50g',
  #       carbs: '35g',
  #       sugars: '7g',
  #       fibers: '10g'
  #       }
  #     }
  #     post '/recipe', params: recipe_params
  #     recipe = JSON.parse(response.body)
  #     puts "****** ", response.body
  #     expect(response).to have_http_status(422)
  #     expect(recipe['title']).to include "can't be blank"
  #   end
  # end

    # describe "Cannot create a cow without valid attributes" do
    #   it 'cannot create a cow without a valid name' do
    #     cow_params = {
    #       cow: { 
    #         age: 14,
    #         enjoys: "sleeping",
    #         color: "white",
    #         species: "limousin",
    #         image: "cowsonly.com",
    #       }
    #     }
    #     post '/cows', params: cow_params
    #     cow = JSON.parse(response.body)
    #     puts "****** ", response.body
        
    #     expect(response).to have_http_status(422)
    #     expect(cow['name']).to include "can't be blank"
    #   end

    # it 'cannot create a recipe without a valid substitution' do
    #   recipe_params = {
    #     recipe: { 
    #     title: "Burger",
    #     ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
    #     servings: '1',
    #     instructions: 'cook to medium',
    #     image: 'url',
    #     cooktime: '7 Minute',
    #     fats: '15g',
    #     calories: '450',
    #     protiens: '50g',
    #     carbs: '35g',
    #     sugars: '7g',
    #     fibers: '10g'
    #     }
    #   }
    #   post '/recipes', params: recipe_params
    #   recipe = JSON.parse(response.body)

    #   expect(response).to have_http_status(422)
    #   expect(json['subsitution']).to include "can't be blank"
    # end
end



