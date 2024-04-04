      user1 = User.where(email:'testing1@example.com').first_or_create(password:'password', password_confirmation:'password')

      user2 = User.where(email:'testing2@example.com').first_or_create(password:'password', password_confirmation:'password')

      recipes = [
        {
          title: 'Mahi Mahi Tacos',
          ingredients: '2 medium limes
          3 tablespoons vegetable oil, divided
          1 3/4 teaspoons kosher salt, divided, plus more as needed
          1 teaspoon chili powder
          1/2 teaspoon smoked paprika
          1/2 teaspoon garlic powder
          1 1/2 pounds skin',
          instructions: 'Finely grate the zest from 1 medium lime (about 2 teaspoons) into a medium bowl. Add 1 tablespoon of the vegetable oil, 1 1/4 teaspoons of the kosher salt, 1 teaspoon chili powder, 1/2 teaspoon smoked paprika, and 1/2 teaspoon garlic powder and stir to combine.
          Cut 1 1/2 pounds mahi-mahi into 1 1/2 to 2-inch pieces. Add to the spice mixture and toss to coat. Set aside for about 15 minutes while you prepare the avocado sauce and slaw.
          Clean the cutting board. Juice the zested lime until you have 2 tablespoons, juicing the second lime as needed, an',
          servings: '4',
          cooktime: '20 Minutes',
          preptime: '10 <inutes',
          totaltime: '30 Minutes',
          image: 'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_913/k%2FPhoto%2FRecipes%2F2022-04_Mahi-Mahi-Tacos%2F2022-04-26_ATK3523',
          calories: '516',
          fats: '23.8 g (36.6%)',
          carbs: '35.9 g (12.0%)',
          proteins: '43.3 g (86.5%)',
          fibers: '9.2 g (36.8%)',
          sugars: '4.5 g',
          description: 'test',
          user_id: 1
        },
        {
          title: 'Chicken Tacos',
          ingredients: '1 pound boneless, skinless chicken thighs
          1 medium lime
          1 teaspoon ground cumin
          1 teaspoon kosher salt
          1/2 teaspoon paprika
          1 tablespoon canola oil, or other neutral cooking oil
          12 corn ',
          instructions: 'Cut 1 pound boneless, skinless chicken thighs into 1-inch pieces and place in a medium bowl. Squeeze the juice of 1 medium lime onto the chicken. Add 1 teaspoon ground cumin, 1 teaspoon kosher salt, and 1/2 teaspoon paprika, and toss to combine. Cover and refrigerate for 30 minutes. Meanwhile, prep the toppings.
          Prep the desired toppings: cut red cabbage into shreds, grate cotija or other desired cheeses, chop cilantro, thinly',
          servings: '4',
          cooktime: '30 Minutes',
          preptime: '10 <inutes',
          totaltime: '30 Minutes',
          image: 'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_913/k%2FPhoto%2FRecipes%2F2019-11-Lesley-Tellez-Tacos%2F2019-11-10_92029_Lesley-Tellez-Tacos',
          calories: '351',
          fats: '10.5 g (16.1%)',
          carbs: '39.0 g (13.0%)',
          proteins: '27.2 g (54.3%)',
          fibers: '6.2 g (24.8%)',
          sugars: '2.6 g',
          description: 'test',
          user_id: 1
        },
        {
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
          preptime: '10 <inutes',
          totaltime: '30 Minutes',
          image: 'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_913/k%2FPhoto%2FRecipes%2F2020-11-How-to-Make-Beef-Birria-Tacos%2F2020-11-24_ATK_37123',
          calories: '327',
          fats: '21.7 g (33.4%)',
          carbs: '12.7 g (4.2%)',
          proteins: '21.4 g (42.7%)',
          fibers: '2.2 g (8.8%)',
          sugars: '1.2 g',
          description: 'test',
          user_id: 2
        }
      ]
          
        recipes.each do |recipe|
          Recipe.create(recipe)
          puts "Creating recipe: #{recipe[:title]}"
        end
        