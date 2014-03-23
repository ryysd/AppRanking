class AddTimeStampToRanking < ActiveRecord::Migration
  def change
    remove_column :rankings, :last_updated_on
    add_column :rankings, :updated_at, :datetime
    add_column :rankings, :created_at, :datetime
  end
end
