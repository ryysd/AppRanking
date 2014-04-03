class AddBannerUrlToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :banner_url, :string, :limit => 128
  end
end
