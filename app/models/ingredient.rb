class Ingredient < ActiveRecord::Base
  include Comparable

  belongs_to :recipe

  validates :quantity, :numericality => { :greater_than => 0 }
  validates_presence_of :unit, :food

  def self.from_text(text)
    self.new(:quantity => text.split(" ").first, :unit => text.split(" ").second, :food => text.split(" ")[2..-1].join(" "))
  end

  def quantity=(quantity)
    if String === quantity
      if quantity =~ /(\d+)\/(\d+)/
        quantity = $1.to_f / $2.to_f
      else
        quantity = quantity.to_i
      end
    end
    super quantity
  end

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
