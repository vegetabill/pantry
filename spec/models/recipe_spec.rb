require 'spec_helper'

describe Recipe do
  it "must have a name" do
    recipe = Recipe.new
    recipe.valid?.should eq false
    recipe.should have(1).errors_on(:name)
  end

  it "should know its a source" do
    recipe = Recipe.new(:source => 'my own brain')
    recipe.source.should eq 'my own brain'
  end

  it "should have ingredients" do
    recipe = Recipe.create!(:name => 'Chickpea Casserole')
    recipe.ingredients.create! :quantity => 15, :unit => 'oz', :food => 'chickpeas'
    recipe.ingredients.count.should eq 1
  end

  it "can be built from lines of text" do
    lines = ["1 quart karo syrup","1 tsp red food coloring", "1/4 C chocolate syrup"]
    recipe = Recipe.from_list "Fake Blood", lines
    recipe.save!
    recipe.ingredients.count.should eq 3
    recipe.ingredients.first.food.should eq "karo syrup"
  end
end
