class CreateOsTypes < ActiveRecord::Migration
  def change
    create_table :os_types do |t|
      t.string :name, :null => false, :limit => 32
    end

    add_column :devices, :os_types, :integer, :null => false
  end
end
