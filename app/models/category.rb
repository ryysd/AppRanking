class Category < ActiveRecord::Base
  has_many :app_items
  belongs_to :market

  scope :market_unique_name, lambda {|name, market_id| where(['name = ? and market_id = ?', name, market_id])}

  def to_json
    {code: self.code, name: self.name}
  end
end
