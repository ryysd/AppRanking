class Category < ActiveRecord::Base
  has_many :app_items, foreign_key: :category_id
  belongs_to :market, foreign_key: :market_id
end
