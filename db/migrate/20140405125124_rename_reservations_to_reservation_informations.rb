class RenameReservationsToReservationInformations < ActiveRecord::Migration
  def change
    rename_table :reservations, :reservation_informations
  end
end
