class ChangeReservationIdToReservationInformation < ActiveRecord::Migration
  def change
    rename_column :bonuses, :reservation_id, :reservation_information_id
  end
end
