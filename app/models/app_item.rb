require 'rubygems'
require 'market_bot'

# TODO: save association of publisher
class AppItem < ActiveRecord::Base
  has_many :rates, :foreign_key => :app_item_id
  has_many :prices, :foreign_key => :app_item_id
  has_many :descriptions, :foreign_key => :app_item_id
  has_many :app_items_devices, :foreign_key => :app_item_id
  has_many :devices, :through => :app_items_devices
  belongs_to :category, :foreign_key => :category_id
  # belongs_to :publisher, :foreign_key => :publisher_id

  accepts_nested_attributes_for :prices
  accepts_nested_attributes_for :descriptions
  accepts_nested_attributes_for :rates
  # accepts_nested_attributes_for :publisher

  attr_accessor :country, :source
  attr_writer :options
  before_save :load

  def options
    @options || {}
  end

  def updatable? (new_app)
    (self.version != new_app.version ||
     (new_app.last_updated_on - self.last_updated_on) * 24 * 60 >= 60)
  end

  private
  def load
    case category.market.code
    when 'GP' then load_google_play
    when 'ITC' then load_itunes_connect
    end
  end

  def load_google_play
    detail = MarketBot::Android::App.new local_id
    detail.update

    self.name            = detail.title
    self.version         = detail.current_version
    self.last_updated_on = detail.updated
    self.icon            = detail.banner_icon_url
    self.size            = detail.size
    self.local_id        = detail.app_id
    self.iap             = false
    
    # remove overlapped objects
    price = Price.new app_item_id: self.id, country_id: country.id, value: (detail.price * 100).to_i
    description = Description.new app_item_id: self.id, country_id: country.id, text: detail.description

    existing_price = prices.find {|p| p.app_item_id == self.id && p.country_id == country.id}
    existing_desc = descriptions.find {|d| d.app_item_id == self.id && d.country_id == country.id}

    if existing_price.nil? then self.prices << price else existing_price.update_attributes (existing_price.attributes.reject! {|k, v| v.nil?}) end
    if existing_desc.nil? then self.descriptions << description else existing_desc.update_attributes (existing_desc.attributes.reject! {|k, v| v.nil?}) end
    self.devices      << (Device.find_by_name 'android')

    detail.rating_distribution.each{|key, value| self.rates << (Rate.new value: key, count: value)}

    # for debug
    self.publisher_id = 0
    # TODO: avoid duplicationg of publisher
    # publisher = Publisher.new name: detail.developer
    # self.publisher = publisher
  end

  def load_itunes_connect
  end
end
