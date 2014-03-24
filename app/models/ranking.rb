require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  attr_accessor :country_code, :feed_code, :market_code, :category_code, :load_params
  attr_writer :options

  has_many :app_items, foreign_key: :ranking_id, autosave: true

  before_create :load

  def options
    @options || {}
  end

  private
  def load
    load_params = make_load_params
    self.feed_id = load_params[:feed].id
    self.country_id = load_params[:country].id

    apps = 
    case market_code
    when 'GP' then load_google_play load_params
    when 'ITC' then load_itunes_connect load_params
    else raise "invalid market code. market_code: #{market_code}"
    end

    add_or_update_apps apps.first(3)
  end

  def load_google_play(country:, feed:, category:)
    # TODO: enable proxy
    leader_boards = MarketBot::Android::Leaderboard.new(feed.code, category.code)
    leader_boards.update options

    raise "could not get ranking. country: #{country}, feed: #{feed}, category: #{category}" if leader_boards.results.blank?

    leader_boards.results.map{|lb| AppItem.new local_id: lb[:market_id], country: country, market: category.market}
  end

  def add_or_update_apps(new_apps)
    new_apps.each do |new_app|
      add_or_update_app new_app
    end
  end

  def add_or_update_app(new_app)
    old_app = (AppItem.market_unique new_app.local_id, new_app.market.id).first

    if !old_app.nil?
      if self.options[:app_update?] || (old_app.updatable? new_app)
	old_app.update_attributes country: new_app.country, market: new_app.market
      end 
    else
      self.app_items << new_app
    end
  end

  def load_itunes_connect (country:, feed:, category:)
  end

  # Return feed, country, category, market data for loading ranking data
  def make_load_params
    params = {
      feed: (Feed.market_unique_code feed_code, market_code).first, 
      country: (Country.find_by_code country_code), 
      category: (Category.find_by_code category_code)
    }

    raise "There is no such feed_code in market. feed_code: #{feed_code}, market_code: #{market_code}" if params[:feed].nil?
    raise "Invalid country_code. country_code: #{country_code}" if params[:country].nil?
    raise "Invalid category_code. category_code: #{category_code}" if params[:category].nil?

    params
  end
end
