require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  attr_accessor :category, :device
  attr_writer :options

  has_many :app_items_rankings
  has_many :app_items, autosave: true, through: :app_items_rankings
  belongs_to :country
  belongs_to :feed

  before_create :set_apps

  TIMEOUT = 5

  def options
    @options || {}
  end

  def initialize(country_code:, feed_code:, market_code:, category_code:, device_name:, options: {})
    super feed: (Feed.market_unique_code feed_code, market_code).first, 
          country: (Country.find_by_code country_code),
	  options: options

    self.category = Category.find_by_code category_code
    self.device = (Device.market_unique_name device_name, feed.market.id).first

    raise "There is no such feed_code in market. feed_code: #{feed_code}, market_code: #{market_code}" if self.feed.nil?
    raise "There is no such device_name in market. device_name: #{device_name}, market_code: #{market_code}" if self.device.nil?
    raise "Invalid country_code. country_code: #{country_code}" if self.country.nil?
    raise "Invalid category_code. category_code: #{category_code}" if self.category.nil?
  end

  private
  def set_apps
    apps = load_apps
    add_or_update_apps apps.first(3)
  end

  def load_apps
    app_keys = 
      case self.category.market.code
      when 'GP' then load_apps_google_play
      when 'ITC' then load_apps_itunes_connect
      else raise "Invalid market code. market_code: #{self.category.market.code}"
      end

    app_keys.map{|key| AppItem.new local_id: key, country: self.country, market: self.category.market, device: self.device}
  end

  def load_apps_google_play
    leader_boards = nil

    # notice: 中国プロキシの場合、香港か台湾かそれ以外かで得られる結果が異なる
    if self.country.own?
      leader_boards =  MarketBot::Android::Leaderboard.new(self.feed.code, self.category.code, self.options)
      leader_boards.update self.options
    else
      valid_proxies = self.country.proxies.where(is_valid: 1).order('protocol_id ASC')
      raise "There are no valid proxies for #{self.country.name}." if valid_proxies.empty?

      valid_proxies.each{|proxy|
	request_opts = {
	  proxy: "#{proxy.host}:#{proxy.port}", 
	  timeout: Ranking::TIMEOUT, 
	  connecttimeout: Ranking::TIMEOUT
	}

	request_opts[:proxytype] = proxy.protocol.name if proxy.protocol.name != 'https' 
	request_opts[:proxytype] = 'socks5' if proxy.protocol.name == 'socks4/5' 

	self.options[:request_opts] = request_opts
	pp proxy
	pp request_opts

	leader_boards =  MarketBot::Android::Leaderboard.new self.feed.code, self.category.code, self.options
	leader_boards.update self.options

	break if !leader_boards.results.blank? 
	proxy.update_attribute(:is_valid, 0)
      }
    end

    raise "Could not get ranking. country: #{self.country.code}, feed: #{self.feed.code}, category: #{self.category.code}" if leader_boards.results.blank?

    leader_boards.results.map{|lb| lb[:market_id]}
  end

  def load_apps_itunes_connect
    limit = self.options[:limit] || 400
    host = 'https://itunes.apple.com'
    query = "#{host}/#{self.country.code}/rss/#{self.feed.code}/limit=#{limit}/genre=#{self.category.code}/json"

    json = RestClient::Request.execute :method => :get, :url => query
    parsed_json = JSON.parse json
    entries = parsed_json['feed']['entry']

    entries.map{|entry| entry['id']['attributes']['im:id'] }
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
    elsif self.options[:app_update?] || (old_app.updatable? new_app)
      old_app.update_attributes country: new_app.country, market: new_app.market, device: new_app.device
    end
  end
end
