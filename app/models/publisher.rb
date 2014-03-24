class Publisher < ActiveRecord::Base
  has_many :app_items, foreign_key: :publisher_id

  scope :market_unique_name, lambda {|name, market_id| where(['name = ? and market_id = ?', name, market_id])}
end
