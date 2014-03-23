class Feed < ActiveRecord::Base
    belongs_to :market, :foreign_key => :market_id

    def find_by_code (code)
      feed = Feed.find :first, 
        :conditions => ['code = ?', code]

      raise "could not get feed. market_code: feed_code: ${feed_code}" if feed.nil?
    end
end
