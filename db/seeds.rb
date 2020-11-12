# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'


3.times do
  open_uri_hash = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/random.php").read)
  drinks_array = open_uri_hash["drinks"][0]

  cocktail = Cocktail.new(name: drinks_array["strDrink"])
  ingredient1 = Ingredient.new(name: drinks_array["strIngredient1"])
  ingredient2 = Ingredient.new(name: drinks_array["strIngredient2"])
  ingredient3 = Ingredient.new(name: drinks_array["strIngredient3"])
  dose1 = Dose.new(description: drinks_array["strMeasure1"])
  dose2 = Dose.new(description: drinks_array["strMeasure2"])
  dose3 = Dose.new(description: drinks_array["strMeasure3"])

  dose1.cocktail = cocktail
  dose2.cocktail = cocktail
  dose3.cocktail = cocktail

  dose1.ingredient = ingredient1
  dose2.ingredient = ingredient2
  dose3.ingredient = ingredient3

  dose1.save
  dose2.save
  dose3.save
end
