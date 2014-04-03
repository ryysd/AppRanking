class RenameBenefitsToBonuses < ActiveRecord::Migration
  def change
    rename_table :benefits, :bonuses
  end
end
