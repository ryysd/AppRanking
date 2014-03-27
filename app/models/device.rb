class Device < ActiveRecord::Base
  has_many :app_items_devices
  has_many :app_items, through: :app_items_devices
  belongs_to :markets

  scope :market_unique_name, lambda {|name, market_id| where(['name = ? and market_id = ?', name, market_id])}
end
