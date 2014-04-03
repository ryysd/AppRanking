require 'rubygems'
require 'market_bot'
require 'yoyakutopten_scraper'

class Ranking < ActiveRecord::Base
  attr_accessor :category, :device
  attr_writer :options

  has_many :app_items_rankings
  has_many :app_items, autosave: true, through: :app_items_rankings
  belongs_to :country
  belongs_to :feed

  # 時間かかってdbエラー出るので、callbackではなく自前で呼ぶ
  # before_create :set_apps

  scope :by_country_code, lambda {|country_code| includes(:country).where(['countries.code = ? ', country_code]).references(:countries)}
  scope :by_market_code, lambda {|market_code| includes([feed: :market]).where(['markets.code = ? ', market_code]).references(:feeds).references(:markets)}
  scope :by_feed_id, lambda {|feed_id| where(['feed_id = ? ', feed_id])}

  TIMEOUT = 5

  def options
    @options || {}
  end

  def initialize(country_code:, feed_code:, market_code:, category_code:, device_name:, options: {})
    super feed: (Feed.market_unique_code feed_code, market_code).first, 
          country: (Country.find_by_code country_code),
	  options: options

    raise "There is no such feed_code in market. feed_code: #{feed_code}, market_code: #{market_code}" if self.feed.nil?
    raise "Invalid country_code. country_code: #{country_code}" if self.country.nil?

    self.category = (Category.market_unique_code category_code, feed.market.id).first
    self.device = (Device.market_unique_name device_name, feed.market.id).first

    raise "Invalid category_code. category_code: #{category_code}" if self.category.nil?
    raise "There is no such device_name in market. device_name: #{device_name}, market_code: #{market_code}" if self.device.nil?
  end

  def self.get_latest_filtered_rankings(country_code:, market_code:, category_code:)
    market = Market.find_by_code market_code
    rankings = ((Ranking.by_country_code country_code).by_market_code market_code).order :updated_at
    feed_rankings = Ranking.get_latest_ranking_of_each_feed rankings, (Feed.by_market_code market_code)

    latest_rankings = feed_rankings.map{|feed, ranking|
      unless ranking.nil?
        cloned_ranking = OpenStruct.new ranking.attributes
	cloned_ranking.app_items = AppItem.filter_by_category ranking.app_items, (Category.market_unique_code category_code, market.id).first
        [feed, cloned_ranking] 
      end
    }.compact

    Hash[*latest_rankings.flatten]
  end

  def self.get_latest_ranking_of_each_feed(rankings, feeds)
    feed_rankings = feeds.map{|feed| {feed => (rankings.by_feed_id feed.id)}}
    latest_rankings = (feed_rankings.reduce Hash.new, :merge).map{|feed, each_feed_rankings| {feed => each_feed_rankings.last} unless each_feed_rankings.nil?}
    latest_rankings.reduce Hash.new, :merge
  end

  def set_apps
    apps = load_apps
    add_or_update_apps apps.first(20)
  end

  private
  def load_apps
    app_keys = 
      case self.category.market.code
      when 'GP' then load_apps_google_play
      when 'ITC' then load_apps_itunes_connect
      when 'RSV' then load_apps_yoyaku_top10
      else raise "Invalid market code. market_code: #{self.category.market.code}"
      end

    app_keys.map do |key| 
      app_id = (key.is_a? Hash) ? key[:app_id] : key
      options = (key.is_a? Hash) ? key[:options] : nil
      AppItem.new local_id: app_id, country: self.country, market: self.category.market, device: self.device, options: options
    end
  end

  def load_apps_google_play
    leader_boards = nil

    category_code = (self.category.code == 'overall') ? nil : self.category.code

    # notice: 中国プロキシの場合、香港か台湾かそれ以外かで得られる結果が異なる
    if self.country.own?
      leader_boards =  MarketBot::Android::Leaderboard.new(self.feed.code, category_code, self.options)
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

	leader_boards =  MarketBot::Android::Leaderboard.new self.feed.code, category.code, self.options
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
    query = "#{host}/#{self.country.code}/rss/#{self.feed.code}/limit=#{limit}"
    query += "/genre=#{self.category.code}" if self.category.code != '0000'
    query += "/json"

    json = RestClient::Request.execute :method => :get, :url => query
    parsed_json = JSON.parse json
    entries = parsed_json['feed']['entry']

    entries.map{|entry| entry['id']['attributes']['im:id'] }
  end

  def load_apps_yoyaku_top10
    os_type = self.device.os_type.name.downcase
    ranking = YoyakutoptenScraper::Ranking.new os_type: os_type.to_sym, feed: self.feed.code.to_sym
    pp ranking
    ranking.update

    raise "Could not get ranking. os_type: #{os_type}, country: #{self.country.code}, feed: #{self.feed.code}, category: #{self.category.code}" if ranking.results.blank?

    ranking.results.map do |app| 
      options = {
	banner_url: app[:banner_img_url],
	price:      app[:price]
      }

      {app_id: app[:app_id], options: options}
    end
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
      old_app.update_attributes country: new_app.country, market: new_app.market, device: new_app.device, options: new_app.options
      old_app.rankings << self unless old_app.rankings.include? self
    end
  end
end
