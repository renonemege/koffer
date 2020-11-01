class ChangePriceToBeFloatInCostOfLivings < ActiveRecord::Migration[6.0]
  def change
    change_column :cost_of_livings, :price, :float
  end
end
