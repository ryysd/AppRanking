class AddOrderToSs < ActiveRecord::Migration
  def change
    add_column :screen_shots, :order, :integer
  end
end
