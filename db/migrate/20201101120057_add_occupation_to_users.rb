class AddOccupationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :occupation, null: false, foreign_key: true
  end
end
