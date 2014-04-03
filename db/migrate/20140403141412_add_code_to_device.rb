class AddCodeToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :code, :string, :limit => 32
  end
end
