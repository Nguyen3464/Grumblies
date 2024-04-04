require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    it "gets a list of recipes" do
      get '/recipes'

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).length).to eq Recipe.count
    end
  end

  describe "POST /recipes" do
    let(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    let(:valid_recipe_params) do
      {
        recipe: {
          title: "Burger",
          ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
          servings: '1',
          instructions: 'cook to medium',
          image: 'url',
          cooktime: '7 Minute',
          preptime: '7 Minute',
          totaltime: '7 Minute',
          description: "this is a test description",
          fats: '15g',
          calories: '450',
          proteins: '50g',
          carbs: '35g',
          sugars: '7g',
          fibers: '10g',
          user_id: user.id
        }
      }
    end

    it "creates a recipe" do
      post '/recipes', params: valid_recipe_params

      if response.status != 200
        puts "Response body: #{response.body}"
      end

      expect(response).to have_http_status(200), "Expected status 200 but got #{response.status}"
      expect(Recipe.last.title).to eq('Burger')
      expect(Recipe.last.ingredients).to eq 'Beef, Bun, Lettuce, Tomato, Cheese'
      expect(Recipe.last.servings).to eq '1'
      expect(Recipe.last.instructions).to eq 'cook to medium'
      expect(Recipe.last.image).to eq 'url'
      expect(Recipe.last.cooktime).to eq '7 Minute'
      expect(Recipe.last.preptime).to eq '7 Minute'
      expect(Recipe.last.totaltime).to eq '7 Minute'
      expect(Recipe.last.fats).to eq '15g'
      expect(Recipe.last.calories).to eq '450'
      expect(Recipe.last.proteins).to eq '50g'
      expect(Recipe.last.carbs).to eq '35g'
      expect(Recipe.last.sugars).to eq '7g'
      expect(Recipe.last.fibers).to eq '10g'
      expect(Recipe.last.description).to eq 'this is a test description'
    end
  end

  describe "PATCH /update" do 
    include Devise::Test::IntegrationHelpers 
    let(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
  
    let!(:recipe) do
      Recipe.create(
        title: "Burger",
        ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
        servings: '1',
        instructions: 'cook to medium',
        image: 'url',
        cooktime: '7 Minute',
        preptime: '7 Minute',
        totaltime: '7 Minute',
        description: "this is a test description",
        fats: '15g',
        calories: '450',
        proteins: '50g',
        carbs: '35g',
        sugars: '7g',
        fibers: '10g',
        user_id: user.id  # Associate the recipe with the user
      )
    end
  
    let(:update_params) do
      {
        recipe: {
          title: "Noodles",
          ingredients: 'Beef, Egg Noodles, Spinach, Tomato, Cheese',
          servings: '4',
          instructions: 'cook to al-dente',
          image: 'url',
          cooktime: '7 Minute',
          preptime: '7 Minute',
          totaltime: '7 Minute',
          description: "this is a test description",
          fats: '15g',
          calories: '450',
          proteins: '50g',
          carbs: '35g',
          sugars: '7g',
          fibers: '10g'
        }
      }
    end
  
    it "updates a recipe" do
      # Authenticate the user before making the request
      sign_in user
  
      patch "/recipes/#{recipe.id}", params: update_params
  
      expect(response).to have_http_status(200)
  
      recipe.reload
  
      expect(recipe.title).to eq "Noodles"
      expect(recipe.ingredients).to eq "Beef, Egg Noodles, Spinach, Tomato, Cheese"
      expect(recipe.servings).to eq "4"
      expect(recipe.instructions).to eq "cook to al-dente"
    end
  end

  describe "DELETE /destroy" do 

    include Devise::Test::IntegrationHelpers 
  
    let(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:recipe) do
      Recipe.create(
        title: "Burger",
        ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
        servings: '1',
        instructions: 'cook to medium',
        image: 'url',
        cooktime: '7 Minute',
        preptime: '7 Minute',
        totaltime: '7 Minute',
        fats: '15g',
        calories: '450',
        proteins: '50g',
        carbs: '35g',
        sugars: '7g',
        fibers: '10g',
        user_id: user.id
      )
    end
    
    before do
      sign_in user
    end
    
    it "will delete a recipe" do
      # Ensure that the recipe exists before attempting to delete it
      expect(Recipe.find_by(id: recipe.id)).not_to be_nil
    
      p "Before deletion: #{Recipe.find_by(id: recipe.id)}"
    
      delete "/recipes/#{recipe.id}"
    
      # Ensure that the response status is as expected
      p "Response status: #{response.status}"
      expect(response).to have_http_status(200), "Expected status 200 but got #{response.status}"
    
      # Ensure that the recipe is deleted from the database
      expect(Recipe.find_by(id: recipe.id)).to be_nil
    
      p "After deletion: #{Recipe.find_by(id: recipe.id)}"
    end
    
  end
  
  
  
  
  
  

  # describe "Validation" do 
  #   let(:invalid_recipe_params) do
  #     {
  #       recipe: { 
  #         title: nil,
  #         ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
  #         servings: '1',
  #         instructions: 'cook to medium',
  #         image: 'url',
  #         cooktime: '7 Minute',
  #         preptime: '7 Minute',
  #         totaltime: '7 Minute',
  #         fats: '15g',
  #         calories: '450',
  #         proteins: '50g',
  #         carbs: '35g',
  #         sugars: '7g',
  #         fibers: '10g',
  #         description: "this is a test description"
  #       }
  #     }
  #   end

  #   it 'cannot create a recipe without a valid title' do
  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['title']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid ingredients' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:ingredients] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['ingredients']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid servings' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:servings] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['servings']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid instructions' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:instructions] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['instructions']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid image' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:image] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['image']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid cooktime' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:cooktime] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['cooktime']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid preptime' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:preptime] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['preptime']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid totaltime' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:totaltime] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['totaltime']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid fats' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:fats] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['fats']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid calories' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:calories] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['calories']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid proteins' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:proteins] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['proteins']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid carbs' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:carbs] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['carbs']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid sugars' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:sugars] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['sugars']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid fibers' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:fibers] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['fibers']).to include "can't be blank"
  #   end

  #   it 'cannot create a recipe without valid description' do
  #     invalid_recipe_params[:recipe][:title] = 'Burger'
  #     invalid_recipe_params[:recipe][:description] = nil

  #     post '/recipes', params: invalid_recipe_params
  #     recipe = JSON.parse(response.body)
  #     expect(response).to have_http_status(422)
  #     expect(recipe['description']).to include "can't be blank"
  #   end

  # end
end
