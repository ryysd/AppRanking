require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  attr_accessor :country_code, :feed_code, :market_code, :category_code, :options, :load_params

  has_many :app_items, :foreign_key => :ranking_id

  before_create :load

  accepts_nested_attributes_for :app_items

  def load
    load_params = make_load_params

    case market_code
    when 'GP' then load_google_play load_params
    when 'ITC' then load_itunes_connect load_params
    else raise "invalid market code. market_code: #{market_code}"
    end
  end

  def load_google_play (country:, feed:, category:)
    # TODO: enable proxy
    lb = MarketBot::Android::Leaderboard.new(feed.code, category.code)
    lb.update options

    raise "could not get ranking. country: #{country}, feed: #{feed}, category: #{category}" if lb.results.blank?

    # debug code
    debug_max_count = 3
    debug_count = 0

    lb.results.each do |app|
      app_item = AppItem.new country: country, category: category, source: app[:market_id]
      app_item.load
      self.app_items << app_item

      # debug code
      if (debug_count+=1) == debug_max_count then break end
    end
  end

  def load_itunes_connect (country:, feed:, category:)
  end

  # Return feed, country, category, market data for loading ranking data
  def make_load_params
    params = {
      country: (Country.find_by_code country_code), 
      category: (Category.find_by_code category_code), 
      feed: (Feed.find :first, {:include => :market, :conditions => 'feed.code = ? and market.code = ?'}, feed_code, market_code), 
    }

    raise "invalid code. feed_code: #{feed_code}, country_code: #{country_code}, category_code: #{category_code}, market_code: #{market_code}" if params.include? nil

    params
  end
end
