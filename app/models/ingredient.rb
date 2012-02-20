class Ingredient < ActiveRecord::Base
  include Comparable

  validates :quantity, :numericality => { :greater_than => 0 }

  def unit=(unit)
    super unit.singularize
  end

  def +(another)
    self.class.new(:quantity => another.quantity + self.quantity, :unit => self.unit)
  end

  def <=>(another)
    self.quantity <=> another.quantity
  end

end
