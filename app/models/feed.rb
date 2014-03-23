class Feed < ActiveRecord::Base
    belongs_to :market, :foreign_key => :market_id
end
