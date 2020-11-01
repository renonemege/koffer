class CreateCityDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :city_details do |t|
      t.string :title
      t.float :value
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
