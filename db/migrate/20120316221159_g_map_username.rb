class GMapUsername < ActiveRecord::Migration
  def up
    add_column :g_maps, :username, :string
  end

  def down
    remove_column :g_maps, :username, :string
  end
end
