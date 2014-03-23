class Market < ActiveRecord::Base
    has_many :categories, :foreign_key => :market_id
end
