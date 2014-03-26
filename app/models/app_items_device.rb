class AppItemsDevice < ActiveRecord::Base
  belongs_to :app_item
  belongs_to :device
end
