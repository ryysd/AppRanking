class AppItemsRanking < ActiveRecord::Base
  belongs_to :app_item
  belongs_to :ranking
end
