class CreateOccupations < ActiveRecord::Migration[6.0]
  def change
    create_table :occupations do |t|
      t.string :title
      t.integer :salary
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
