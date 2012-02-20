require 'spec_helper'

describe Ingredient do

  it "should have ingredient quantity" do
    ingredient = Ingredient.new(:quantity => 0)
    ingredient.quantity.should eq 0
  end

  it "should not allow less than 0 as quantity" do
    [-1, 0, nil].each do |qty|
      ingredient = Ingredient.new(:quantity => qty)
      ingredient.valid?.should eq false
      ingredient.should have(1).errors_on(:quantity)
    end
  end

  it "must have a food" do
    ingredient = Ingredient.new
    ingredient.valid?.should eq false
    ingredient.should have(1).errors_on(:food)
  end

  it "must have a unit" do
    ingredient = Ingredient.new
    ingredient.valid?.should eq false
    ingredient.should have(1).errors_on(:unit)
  end

  it "should know its unit" do
    ingredient = Ingredient.new(:quantity => 1, :unit => "oz")
    ingredient.unit.should eq "oz"
  end

  it "should singularize its unit" do
    ingredient = Ingredient.new(:quantity => 2, :unit => "cups")
    ingredient.unit.should eq "cup"
  end

  it "should be addable to another" do
    first = Ingredient.new(:quantity => 1, :unit => "cup")
    second = Ingredient.new(:quantity => 2, :unit => "cups")
    (first + second).quantity.should eq 3
    (first + second).unit.should eq "cup"
  end

  it "should not be addable to another with a different unit" do
    first = Ingredient.new(:quantity => 1, :unit => "cup")
    second = Ingredient.new(:quantity => 2, :unit => "ounces")
    lambda { first + second }.should raise_error
  end

  it "should be comparable to another" do
    first = Ingredient.new(:quantity => 1, :unit => "cup")
    second = Ingredient.new(:quantity => 2, :unit => "cups")
    (first == second).should eq false
    (first > second).should eq false
    (first < second).should eq true
  end

end
