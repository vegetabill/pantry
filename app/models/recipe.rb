class Recipe < ActiveRecord::Base

  has_many :ingredients
  validates_presence_of :name

  def self.from_list(name, list)
    recipe = self.new(:name => name)
    list.each do |ingredient_text|
      ingredient = Ingredient.from_text(ingredient_text)
      raise ingredient.errors.full_messages.join("\n") unless ingredient.valid?
      recipe.ingredients << ingredient
    end
    recipe
  end

end
