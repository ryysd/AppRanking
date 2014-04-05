class AddVideoUrlToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :video_url, :string, :limit => 128
  end
end
