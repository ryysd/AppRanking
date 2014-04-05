class Feed < ActiveRecord::Base
  belongs_to :market
  has_many :rankings

  scope :market_unique_code, lambda {|feed_code, market_code| includes(:market).where("feeds.code = ? and markets.code = ?", feed_code, market_code).references(:market)}
  scope :by_market_code, lambda {|market_code| includes(:market).where("markets.code = ?", market_code).references(:market)}
  scope :by_market_id, lambda {|market_id| where("market_id = ?", market_id)}

  def to_json
    {code: self.code, name: self.name}
  end
end
