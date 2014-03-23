require 'rubygems'
require 'market_bot'

class AppItem < ActiveRecord::Base
  has_many :rates, :foreign_key => :app_item_id

  def load (market:, data:)
    case market.code
    when 'GP'
      load_google_play data
    when 'ITC'
      load_itunes_connect data
    else
      raise "invalid market code. market_code: #{market_code}"
    end
  end

  private
  def load_google_play_data (data)
    detail = MarketBot::Android::App.new data[:market_urlid]
    detail.update

    @name            = detail.title
    @version         = detail.current_version
    @last_updated_on = detail.updated
    @icon            = detail.banner_icon_url
    @size            = detail.size
    pp detail.price
  end

  def load_itunes_connect_data (data)
  end
end
