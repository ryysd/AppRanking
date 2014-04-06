class Reservation < ActiveRecord::Base
  belongs_to :app_item
  belongs_to :user
end
