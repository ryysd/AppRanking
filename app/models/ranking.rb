require 'rubygems'
require 'market_bot'

class Ranking < ActiveRecord::Base
  def load (country_code:, feed_code:, market_code:, category_code:, **opts)
    feed = Feed.find_by_code feed_code
    country = Country.find_by_code country_code
    category = Category.find_by_code category_code

    load_args = {country: country, feed: feed, category: category, opts: opts}

    case market_code
    when 'GP'
      load_google_play load_args
    when 'ITC'
      load_itunes_connect load_args
    else
      raise "invalid market code. market_code: #{market_code}"
    end
  end

  private
  def load_google_play (country:, feed:, category:, **opts)
    lb = MarketBot::Android::Leaderboard.new(feed.code, category.code)
    lb.update

    lb.results.each do |app|
      app_item = AppItem.new
      app_item.load market: feed.market, data: app[:market_id]
    end
  end

  def load_itunes_connect (country:, feed:, category:, **opts)
  end
end
