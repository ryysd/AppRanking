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
  before_create :load

  def load
    case category.market.code
    when 'GP' then load_google_play
    when 'ITC' then load_itunes_connect
    end
  end

  def load_google_play
    detail = MarketBot::Android::App.new source
    detail.update

    self.name            = detail.title
    self.version         = detail.current_version
    self.last_updated_on = detail.updated
    self.icon            = detail.banner_icon_url
    self.size            = detail.size
    self.local_id        = detail.app_id
    self.iap             = false

    # for debug
    self.publisher_id = 0
    
    detail.rating_distribution.each do |key, value|
      rate = Rate.new value: key, count: value
      self.rates << rate
    end

    self.devices << (Device.find_by_name 'android')

    # TODO: avoid duplicationg of country (if country_id is duplicated, use update instead of save)
    self.prices << (Price.new country_id: country.id, value: (detail.price * 100).to_i)
    self.descriptions << (Description.new country_id: country.id, text: detail.description)

    # TODO: avoid duplicationg of publisher
    # publisher = Publisher.new name: detail.developer
    # self.publisher = publisher
  end

  def load_itunes_connect
  end
end
