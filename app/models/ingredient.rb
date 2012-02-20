class Ingredient < ActiveRecord::Base
  include Comparable

  belongs_to :recipe

  validates :quantity, :numericality => { :greater_than => 0 }
  validates_presence_of :unit, :food

  def unit=(unit)
    super unit.singularize
  end

  def +(another)
    raise "Cannot add ingredients together.  Units do not match: #{self.unit} != #{another.unit}" if self.unit != another.unit
    self.class.new(:quantity => another.quantity + self.quantity, :unit => self.unit)
  end

  def <=>(another)
    self.quantity <=> another.quantity
  end

end
