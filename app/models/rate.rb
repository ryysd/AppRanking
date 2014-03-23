class Rate < ActiveRecord::Base
  accepts_nested_attributes_for :app_item
end
