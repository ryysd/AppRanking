class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :released_on, :null => false
      t.integer :reserved_num, :null => false
      t.integer :max_reserved_num, :null => false
      t.integer :app_item_id, :null => false

      t.timestamps
    end
  end
end
