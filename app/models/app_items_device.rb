class AppItemsDevice < ActiveRecord::Base
  belongs_to :app_item, foreign_key: :app_item_id
  belongs_to :device, foreign_key: :device_id
end
