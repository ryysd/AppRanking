class AddIsPopularColumnToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :is_popular, :boolean
  end
end
