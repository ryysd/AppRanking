class Publisher < ActiveRecord::Base
  has_many :app_items, :foreign_key => :publisher_id
end
