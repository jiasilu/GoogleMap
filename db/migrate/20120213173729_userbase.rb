class Userbase < ActiveRecord::Migration
  def up
    rename_column :users, :name, :username
    add_column :users, :email, :string
    rename_column :users, :password_digest, :password
    add_column :users, :verify_password, :string
  end
  def down
    remove_column :users, :email
    remove_column :users, :verify_password
  end
end
