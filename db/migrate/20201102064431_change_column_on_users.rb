class ChangeColumnOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :occupation_id, :bigint, :null => true
  end
end