class Device < ActiveRecord::Base
  has_many :app_items_devices
  has_many :app_items, :through => :app_items_devices
end
