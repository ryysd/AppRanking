require 'rubygems'
require 'market_bot'

class AppItem < ActiveRecord::Base
  has_many :rates, :foreign_key => :app_item_id
  has_many :nationals, :foreign_key => :app_item_id
  belongs_to :category, :foreign_key => :category_id
  belongs_to :publisher, :foreign_key => :publisher_id

  accepts_nested_attributes_for :nationals
  accepts_nested_attributes_for :publisher
  accepts_nested_attributes_for :rates

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
    
    detail.rating_distribution do |key, value|
      rate = Rate.new value: key, count: value
      self.rates << rate
    end

    national = National.new country_id: country.id, description: detail.description, price: detail.price
    self.nationals = [national]

    # TODO: avoid duplicationg of publisher
    publisher = Publisher.new name: detail.developer
    self.publisher = publisher
  end

  def load_itunes_connect
  end
end
