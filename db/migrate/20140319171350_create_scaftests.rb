class CreateScaftests < ActiveRecord::Migration
  def change
    create_table :scaftests do |t|
      t.string :name
      t.integer :int

      t.timestamps
    end
  end
end
