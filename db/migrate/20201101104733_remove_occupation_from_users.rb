class RemoveOccupationFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :occupation, :string
  end
end
