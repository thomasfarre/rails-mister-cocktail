# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# class AddImageToCocktails < ActiveRecord::Migration[6.0]
#   def change
#     add_column :cocktails, :image, :string
#   end
# end

# (drinks_data["strIngredient#{i}"] != (nil || "") && drinks_data["strMeasure#{i}"]) != (nil || "")
require 'open-uri'
require 'json'

# puts "Destroy all..."

# Dose.destroy_all
# Cocktail.destroy_all
# Ingredient.destroy_all

# puts "Everything destroyed!"



16.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  data = JSON.parse(open(url).read)
  drinks_data = data['drinks'][0]

  file = URI.open(drinks_data['strDrinkThumb'])

  if Cocktail.where(name: drinks_data['strDrink']).exists?

    cocktail = Cocktail.find_by(name: drinks_data['strDrink'])

  else

    cocktail = Cocktail.new(name: drinks_data['strDrink'])
    cocktail.photo.attach(io: file, filename: 'cocktail.jpg', content_type: 'image/jpg')
    cocktail.save

  end

  i = 1

  while true

    if Ingredient.where(name: drinks_data["strIngredient#{i}"]).exists?

      ingredient = Ingredient.find_by(name: drinks_data["strIngredient#{i}"])

      dose = Dose.new(description: drinks_data["strMeasure#{i}"])

      dose.ingredient = ingredient
      dose.cocktail = cocktail

      break unless dose.valid?

      dose.save!
      i += 1

    else

      ingredient = Ingredient.new(name: drinks_data["strIngredient#{i}"])

      break unless ingredient.valid?

      dose = Dose.new(description: drinks_data["strMeasure#{i}"])

      dose.ingredient = ingredient
      dose.cocktail = cocktail

      break unless dose.valid?

      dose.save!
      i += 1
    end
  end
end

puts '--------------------------------'
puts 'create cocktails successfull'
puts '--------------------------------'

  # open_uri_hash = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/random.php").read)
  # drinks_array = open_uri_hash["drinks"][0]

  # cocktail = Cocktail.new(name: drinks_array["strDrink"], image: drinks_array["strDrinkThumb"])
  # ingredient1 = Ingredient.new(name: drinks_array["strIngredient1"])
  # ingredient2 = Ingredient.new(name: drinks_array["strIngredient2"])
  # ingredient3 = Ingredient.new(name: drinks_array["strIngredient3"])
  # dose1 = Dose.new(description: drinks_array["strMeasure1"])
  # dose2 = Dose.new(description: drinks_array["strMeasure2"])
  # dose3 = Dose.new(description: drinks_array["strMeasure3"])

  # dose1.cocktail = cocktail
  # dose2.cocktail = cocktail
  # dose3.cocktail = cocktail

  # dose1.ingredient = ingredient1
  # dose2.ingredient = ingredient2
  # dose3.ingredient = ingredient3

  # dose1.save!
  # dose2.save!
  # dose3.save!

