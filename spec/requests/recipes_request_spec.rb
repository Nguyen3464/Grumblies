require 'rails_helper'

RSpec.describe "Recipes", type: :request do
    let(:user) { User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
    )}

    #before saves the instance of user to the database so that it can be accessed withing the describe block
    before { user.save }

    describe "Get /index" do
        it 'gets a list of recipes' do
            recipe = user.recipes.create(
                title: 'Birria Tacos',
                ingredients: '3 1/2 pounds boneless beef chuck roast
                3 teaspoons kosher salt, divided, plus more as needed
                1 teaspoon freshly ground black pepper
                4 dried guajillo chiles
                2 dried ancho chiles
                1 large white onion
                5 cloves peeled garlic',
                instructions: 'Cut and season the beef. Cut 3/12 pounds chuck roast into 12 pieces. Season with 2 teaspoons of the kosher salt and 1 teaspoon ground black pepper.
                Prepare the chiles, onion, and ginger. Using kitchen shears, cut the stems from 4 guajillo and 2 ancho chiles. Remove the seeds. Peel and halve 1 large white onion. Peel 1-inch fresh ginger and cut in half. Place the chiles, half the onion (re',
                servings: '18',
                cooktime: '2 Hours 45 Minutes',
                preptime: '10 <Minutes',
                totaltime: '30 Minutes',
                image: 'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_913/k%2FPhoto%2FRecipes%2F2020-11-How-to-Make-Beef-Birria-Tacos%2F2020-11-24_ATK_37123',
                calories: '327',
                fats: '21.7 g (33.4%)',
                carbs: '12.7 g (4.2%)',
                proteins: '21.4 g (42.7%)',
                fibers: '2.2 g (8.8%)',
                sugars: '1.2 g',
                description: 'testing',
                user_id: user.id
            )
            get '/recipes'

            recipes = JSON.parse(response.body)
            expect(response).to have_http_status(200)
            expect(recipes).not_to be_empty
            expect(recipes[0]['title']).to eq('Birria Tacos')
        end
    end
end