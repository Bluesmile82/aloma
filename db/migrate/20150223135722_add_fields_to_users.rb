class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :profile_picture, :string
    add_column :users, :status, :string
    add_column :users, :last_search, :string
  end
end
