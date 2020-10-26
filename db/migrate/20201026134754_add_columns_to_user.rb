class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :occupation, :string
    add_column :users, :description, :text
    add_column :users, :image_url, :string
    add_column :users, :score, :integer
  end
end
