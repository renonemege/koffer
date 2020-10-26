class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :title
      t.text :description
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :quality_of_life
      t.integer :income
      t.integer :living_cost
      t.string :traffic
      t.integer :population
      t.string :currency
      t.string :weather
      t.integer :score

      t.timestamps
    end
  end
end
