class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.decimal :quantity
      t.string :unit
      t.string :food
      t.timestamps
    end
  end
end
