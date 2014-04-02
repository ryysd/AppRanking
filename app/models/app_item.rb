require 'rubygems'
require 'market_bot'

class AppItem < ActiveRecord::Base
  include MergeAttribute

  has_many :app_items_devices
  has_many :screen_shots     
  has_many :rates, autosave: true
  has_many :prices, autosave: true
  has_many :descriptions, autosave: true
  has_many :devices, through: :app_items_devices
  has_many :app_items_rankings
  has_many :rankings, through: :app_items_rankings
  belongs_to :category 
  belongs_to :publisher
  # belongs_to :publisher, :foreign_key => :publisher_id

  attr_accessor :country, :market, :device, :source
  attr_writer :options
  before_save :set_detail_data

  scope :market_unique, lambda {|local_id, market_id| includes([:category]).where(['local_id = ? and market_id = ?', local_id, market_id]).references(:category)}
  scope :by_category_code, lambda {|category_code| includes([:category]).where(['categories.code = ?', category_code]).references(:category)}

  UPDATE_INTERVAL_MIN = 60

  def options
    @options || {}
  end

  def updatable?(new_app)
    (self.version != new_app.version ||
    (Time.now - self.updated_at) /  60 >= AppItem::UPDATE_INTERVAL_MIN)
  end

  def self.filter_by_category(app_items, category)
    categories = category.childs
    app_items.select{|app_item| categories.include? app_item.category}
  end

  private
  def set_detail_data
    detail = load_app_detail
    add_or_update_attributes detail
  end

  def load_app_detail
      case market.code
      when 'GP' then load_app_detail_google_play
      when 'ITC' then load_app_detail_itunes_connect
      end
  end

  def load_app_detail_google_play
    # TODO: enable proxy
    detail = MarketBot::Android::App.new self.local_id
    detail.update

    assignable_attributes =
    {
      name:              detail.title,
      version:           detail.current_version,
      last_updated_on:   detail.updated,
      icon:              detail.banner_icon_url,
      size:              detail.size,
      local_id:          detail.app_id,
      website_url:       "https://play.google.com/store/apps/details?id=#{detail.app_id}",
      iap:               false,
    }

    unassignable_attributes =
    {
      price:             detail.price,
      screen_shots_urls: detail.screenshot_urls,
      description:       detail.description,
      publisher_name:    detail.developer,
      ratings:           detail.rating_distribution,
      category_name:     detail.category,
      device_name:       self.device.name
    }

    {assignable__attributes: assignable_attributes, unassignable_attributes: unassignable_attributes}
  end

  def load_app_detail_itunes_connect
    host = "https://itunes.apple.com"
    query = "#{host}/#{self.country.code}/lookup?id=#{self.local_id}"

    json = RestClient::Request.execute :method => :get, :url => query
    parsed_json = JSON.parse json
    detail = OpenStruct.new parsed_json['results'].first

    assignable_attributes =
    {
      name:              detail.trackName,
      version:           detail.version,
      last_updated_on:   '',
      released_on:       detail.releaseDate,
      icon:              detail.artworkUrl60,
      size:              (detail.fileSizeBytes.to_i / (1024 * 1024)),
      local_id:          detail.trackId,
      website_url:       detail.trackViewUrl,
      iap:               false,
    }

    unassignable_attributes =
    {
      price:             detail.price,
      screen_shots_urls: detail.screenshotUrls,
      description:       detail.description,
      publisher_name:    detail.artistName,
      ratings:           {},
      category_name:     detail.primaryGenreName,
      device_name:       self.device.name
    }

    {assignable__attributes: assignable_attributes, unassignable_attributes: unassignable_attributes}
  end

  def add_or_update_attributes(assignable__attributes:, unassignable_attributes:)
    self.assign_attributes assignable__attributes
    assign_category unassignable_attributes[:category_name]
    add_or_update_price unassignable_attributes[:price]
    add_or_update_description unassignable_attributes[:description]
    add_or_update_device unassignable_attributes[:device_name]
    add_or_update_ratings unassignable_attributes[:ratings]
    add_or_update_screenshot_urls unassignable_attributes[:screen_shots_urls]
    new_or_update_publisher unassignable_attributes[:publisher_name]
  end

  def assign_category(category_name)
    self.category = (Category.market_unique_name category_name, self.market.id).first
    raise "undefined category name is found. category_name: #{category_name}" if self.category.nil?
  end

  def add_or_update_price(price)
    new_price = Price.new country_id: country.id, value: (price * 100).to_i
    old_price = self.prices.find{|p| p.country_id == country.id}
    merge_attribute self.prices, old_price, new_price
  end

  def add_or_update_description(description)
    new_description = Description.new country_id: country.id, text: description
    old_description = self.descriptions.find{|d| d.country_id == country.id}
    merge_attribute self.descriptions, old_description, new_description
  end

  def add_or_update_device(device_name)
    new_device = Device.find_by_name device_name
    old_device = self.devices.find{|d| d.name == device_name}
    merge_attribute self.devices, old_device, new_device
    raise "There is no such device in market. device_name: #{device_name}, market_name: #{self.market.name}" unless self.market.devices.map{|d| d.name}.include? device_name
  end

  def add_or_update_ratings(ratings)
    ratings.each {|key, value| 
      old_rate = self.rates.find {|r| r.value == key}
      new_rate = Rate.new value: key, count: value
      merge_attribute self.rates, old_rate, new_rate
    }
  end

  def add_or_update_screenshot_urls(urls)
    self.screen_shots.slice! 0, urls.length
    urls.each_with_index {|url, idx|
      old_ss = self.screen_shots[idx]
      new_ss = ScreenShot.new url: url, order: idx + 1
      merge_attribute self.screen_shots, old_ss, new_ss
    }
  end

  def new_or_update_publisher(publisher_name)
    old_publisher = (Publisher.market_unique_name publisher_name, self.market.id).first
    new_publisher = Publisher.new name: publisher_name, market_id: self.market.id

    self.publisher = old_publisher
    if self.publisher.nil?
      self.publisher = new_publisher
      self.publisher.save
    end

    self.publisher_id = self.publisher.id
  end
end
