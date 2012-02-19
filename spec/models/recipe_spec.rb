require 'spec_helper'

describe Recipe do
  it "should have a name" do
    recipe = Recipe.new(:name => "Fried Ham")
    recipe.name.should eq "Fried Ham"
  end
end
