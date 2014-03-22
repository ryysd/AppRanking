class ChangeRelationShip < ActiveRecord::Migration
  def change
      rename_column :currencies, :language_id, :country_id
      add_column :languages, :country_id, :integer, :null => false
      rename_column :nationals, :language_id, :country_id
  end
end
