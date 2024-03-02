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

  describe "PATCH /update" do 
    it "updates a recipe" do
      recipe = Recipe.create(
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
    update_params = {
      recipe: {
        title: "Noodles",
        subsitution: "Rice noodles",
        ingredients: 'Beef, Egg Noodles, Spinach, Tomato, Cheese',
        servings: '4',
        instructions: 'cook to al-dente',
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
      patch "/recipes/#{recipe.id}", params: update_params

      expect(response).to have_http_status(200)

      recipe = Recipe.first
      expect(recipe.title).to eq "Noodles"
      expect(recipe.subsitution).to eq "Rice noodles"
      expect(recipe.ingredients).to eq "Beef, Egg Noodles, Spinach, Tomato, Cheese"
      expect(recipe.servings).to eq "4"
      expect(recipe.instructions).to eq "cook to al-dente"
    
    end
  end

  describe "cannot create a recipe without valid attributes" do 
    it "will delete a recipe" do
      recipe = Recipe.create(
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

      delete "/recipes/#{recipe.id}"
      expect(response).to have_http_status(200) 
    end
  end

  # Validations

  describe "Cannot create a recipe without valid attributes" do
    it 'cannot create a recipe without a valid title' do
      recipe_params = {
        recipe: { 
        title: nil,
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
      post '/recipes', params: recipe_params
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(recipe['title']).to include "can't be blank"
    end

    it 'cannot create a recipe without a valid ingredients' do
      recipe_params = {
        recipe: { 
        title: "Burger",
        subsitution: "chicken",
        ingredients: nil,
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
      post '/recipes', params: recipe_params
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(recipe['ingredients']).to include "can't be blank"
    end

    it 'cannot create a recipe without a valid servings' do
      recipe_params = {
        recipe: { 
        title: "Burger",
        subsitution: "chicken",
        ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
        servings: nil,
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
      post '/recipes', params: recipe_params
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(recipe['servings']).to include "can't be blank"
    end

  it 'cannot create a recipe without a valid instructions' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: nil,
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
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['instructions']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid image' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: nil,
      cooktime: '7 Minute',
      fats: '15g',
      calories: '450',
      protiens: '50g',
      carbs: '35g',
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['image']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook time' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: nil,
      fats: '15g',
      calories: '450',
      protiens: '50g',
      carbs: '35g',
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['cooktime']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook fats' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: nil,
      calories: '450',
      protiens: '50g',
      carbs: '35g',
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['fats']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook calories' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: '34g',
      calories: nil,
      protiens: '50g',
      carbs: '35g',
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['calories']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook protiens' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: '34g',
      calories: "350",
      protiens: nil,
      carbs: '35g',
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['protiens']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook carbs' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: '34g',
      calories: "350",
      protiens: '50g',
      carbs: nil,
      sugars: '7g',
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['carbs']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook sugars' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: '34g',
      calories: "350",
      protiens: '50g',
      carbs: '40g',
      sugars: nil,
      fibers: '10g'
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['sugars']).to include "can't be blank"
  end

  it 'cannot create a recipe without a valid cook fibers' do
    recipe_params = {
      recipe: { 
      title: "Burger",
      subsitution: "chicken",
      ingredients: 'Beef, Bun, Lettuce, Tomato, Cheese',
      servings: "4",
      instructions: 'cook to medium',
      image: "url",
      cooktime: '7 Minute',
      fats: '34g',
      calories: "350",
      protiens: '50g',
      carbs: '40g',
      sugars: '8g',
      fibers: nil
      }
    }
    post '/recipes', params: recipe_params
    recipe = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(recipe['fibers']).to include "can't be blank"
  end

end
end



