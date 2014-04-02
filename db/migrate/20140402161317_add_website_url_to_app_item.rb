class AddWebsiteUrlToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :website_url, :string, :limit => 128
  end
end
