require 'rubygems'
require 'market_bot'

# TODO: save association of publisher
class AppItem < ActiveRecord::Base
  include MergeAttribute

  has_many :rates, :foreign_key => :app_item_id, :autosave => true
  has_many :prices, :foreign_key => :app_item_id, :autosave => true
  has_many :descriptions, :foreign_key => :app_item_id, :autosave => true
  has_many :app_items_devices, :foreign_key => :app_item_id
  has_many :screen_shots, :foreign_key => :app_item_id
  has_many :devices, :through => :app_items_devices
  belongs_to :category, :foreign_key => :category_id
  # belongs_to :publisher, :foreign_key => :publisher_id

  attr_accessor :country, :source
  attr_writer :options
  before_save :load

  scope :market_unique, lambda {|local_id, market_id| includes([:category]).where(['local_id = ? and market_id = ?', local_id, market_id])}

  UPDATE_INTERVAL_MIN = 60

  def options
    @options || {}
  end

  def updatable? (new_app)
    (self.version != new_app.version ||
    (Time.now - self.updated_at) * 24 * 60 >= AppItem::UPDATE_INTERVAL_MIN)
  end

  private
  def load
    case category.market.code
    when 'GP' then load_google_play
    when 'ITC' then load_itunes_connect
    end
  end

  def load_google_play
    # TODO: enable proxy
    detail = MarketBot::Android::App.new local_id
    detail.update
    raise 'could not get application detail.' if detail.title.nil?

    self.name            = detail.title
    self.version         = detail.current_version
    self.last_updated_on = detail.updated
    self.icon            = detail.banner_icon_url
    self.size            = detail.size
    self.local_id        = detail.app_id
    self.iap             = false
    
    new_price = Price.new app_item_id: self.id, country_id: country.id, value: (detail.price * 100).to_i
    new_device = Device.find_by_name 'android'
    new_description = Description.new app_item_id: self.id, country_id: country.id, text: detail.description

    old_price = prices.find {|p| p.country_id == country.id}
    old_device = devices.find {|d| d.name == 'android'}
    old_description = descriptions.find {|d| d.country_id == country.id}

    merge_attribute self.prices, old_price, new_price
    merge_attribute self.devices, old_device, new_device
    merge_attribute self.descriptions, old_description, new_description

    detail.rating_distribution.each {|key, value| 
      old_rate = self.rates.find {|r| r.value == key}
      new_rate = Rate.new value: key, count: value
      merge_attribute self.rates, old_rate, new_rate
    }

    self.screen_shots.slice! 0, detail.screenshot_urls.length
    detail.screenshot_urls.each_with_index {|url, idx|
      old_ss = self.screen_shots[idx]
      new_ss = ScreenShot.new url: url, order: idx + 1
      merge_attribute self.screen_shots, old_ss, new_ss
    }

    # for debug
    self.publisher_id = 0
    # TODO: avoid duplicationg of publisher
    # publisher = Publisher.new name: detail.developer
    # self.publisher = publisher
  end

  def load_itunes_connect
  end
end
