class Feed < ActiveRecord::Base
  belongs_to :market, foreign_key: :market_id

  scope :market_unique, lambda {|feed_code, market_code| includes(:market).where("feeds.code = ? and markets.code = ?", feed_code, market_code)}
end
