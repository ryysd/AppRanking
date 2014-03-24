class RenameFeedsColumnToFeedInRanking < ActiveRecord::Migration
  def change
    rename_column :rankings, :feeds_id, :feed_id
  end
end
