class CreateGMaps < ActiveRecord::Migration
  def change
    create_table :g_maps do |t|
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
