require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  attr_accessor :category
  attr_writer :options

  has_many :app_items, autosave: true
  belongs_to :country
  belongs_to :feed

  before_create :set_apps

  def options
    @options || {}
  end

  def initialize(country_code:, feed_code:, market_code:, category_code:, options: {})
    super feed: (Feed.market_unique_code feed_code, market_code).first, 
          country: (Country.find_by_code country_code),
	  options: options

    self.category = Category.find_by_code category_code

    raise "There is no such feed_code in market. feed_code: #{feed_code}, market_code: #{market_code}" if self.feed.nil?
    raise "Invalid country_code. country_code: #{country_code}" if self.country.nil?
    raise "Invalid category_code. category_code: #{category_code}" if self.category.nil?
  end

  private
  def set_apps
    apps = load_apps
    add_or_update_apps apps.first(3)
  end

  def load_apps
    case self.category.market.code
    when 'GP' then load_apps_google_play
    when 'ITC' then load_apps_itunes_connect
    else raise "Invalid market code. market_code: #{self.category.market.code}"
    end
  end

  def load_apps_google_play
    # TODO: enable proxy
    leader_boards = MarketBot::Android::Leaderboard.new(self.feed.code, self.category.code)
    leader_boards.update self.options

    raise "Could not get ranking. country: #{self.country}, feed: #{self.feed}, category: #{self.category}" if leader_boards.results.blank?

    leader_boards.results.map{|lb| AppItem.new local_id: lb[:market_id], country: self.country, market: self.category.market}
  end

  def load_apps_itunes_connect
  end

  def add_or_update_apps(new_apps)
    new_apps.each do |new_app|
      add_or_update_app new_app
    end
  end

  def add_or_update_app(new_app)
    old_app = (AppItem.market_unique new_app.local_id, new_app.market.id).first

    if old_app.nil?
      self.app_items << new_app
    else
      if self.options[:app_update?] || (old_app.updatable? new_app)
	old_app.update_attributes country: new_app.country, market: new_app.market
      end 
    end
  end
end
