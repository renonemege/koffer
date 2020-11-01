class CreateCostOfLivings < ActiveRecord::Migration[6.0]
  def change
    create_table :cost_of_livings do |t|
      t.string :title
      t.integer :price
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
