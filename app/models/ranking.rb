require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  attr_accessor :country_code, :feed_code, :market_code, :category_code, :load_params
  attr_writer :options

  has_many :app_items, :foreign_key => :ranking_id, :autosave => true

  before_create :load

  def options
    @options || {}
  end

  private
  def load
    load_params = make_load_params
    self.feed_id = load_params[:feed].id
    self.country_id = load_params[:country].id

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

    lb.results.first(3).each do |app|
      app_item = AppItem.new country: country, category: category, local_id: app[:market_id]
      existing_app = (AppItem.market_unique app_item.local_id, app_item.category.market_id).first

      if !existing_app.nil?
	if options[:app_update?] || (existing_app.updatable? app_item)
	  existing_app.update_attributes country: country
	end 
      else
        self.app_items << app_item
      end
    end
  end

  def load_itunes_connect (country:, feed:, category:)
  end

  # Return feed, country, category, market data for loading ranking data
  def make_load_params
    params = {
      feed: (Feed.market_unique feed_code, market_code).first, 
      country: (Country.find_by_code country_code), 
      category: (Category.find_by_code category_code), 
    }

    raise "invalid code. feed_code: #{feed_code}, country_code: #{country_code}, category_code: #{category_code}, market_code: #{market_code}" if params.include? nil

    params
  end
end
