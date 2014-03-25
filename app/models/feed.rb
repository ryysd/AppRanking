class Feed < ActiveRecord::Base
  belongs_to :market

  scope :market_unique_code, lambda {|feed_code, market_code| includes(:market).where("feeds.code = ? and markets.code = ?", feed_code, market_code)}
end
