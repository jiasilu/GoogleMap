class Userbase1 < ActiveRecord::Migration
  def up
    rename_column :users, :password, :encrypted_password
    rename_column :users, :verify_password, :password_salt
  end

  def down
  end
end
