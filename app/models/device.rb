class Device < ActiveRecord::Base
  has_many :app_items_devices
  has_many :app_items, through: :app_items_devices
  belongs_to :markets
  belongs_to :os_type

  scope :market_unique_name, lambda {|name, market_id| where(['name = ? and market_id = ?', name, market_id])}
  scope :by_market_code, lambda {|market_code| includes(:market).where("markets.code = ?", market_code).references(:market)}
  scope :by_market_id, lambda {|market_id| where("market_id = ?", market_id)}

  def to_json
    {code: self.code, name: self.name}
  end
end
