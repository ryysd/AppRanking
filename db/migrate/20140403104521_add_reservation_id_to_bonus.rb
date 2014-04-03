class AddReservationIdToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :reservation_id, :integer, :null => false
  end
end
