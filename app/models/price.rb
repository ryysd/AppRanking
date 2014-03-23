class Price < ActiveRecord::Base
  accepts_nested_attributes_for :national
end
