class CreateProtocolsTable < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.string :name
    end

    add_column :proxies, :protocol_id, :integer, :null => false
  end
end
