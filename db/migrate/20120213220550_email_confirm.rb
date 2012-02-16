class EmailConfirm < ActiveRecord::Migration
  def up
    add_column :users, :activation_token, :string
    add_column :users, :activation_at, :datetime
  end

  def down
    remove_column :users, :activation_token, :string
    remove_column :users, :activation_at, :datetime
  end
end
