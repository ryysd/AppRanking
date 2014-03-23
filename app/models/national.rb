class National < ActiveRecord::Base
  attr_accessor :description, :price

  accepts_nested_attributes_for :app_item
  
  def before_save
    @description = Description.new text: description
    @price = Price.new value: (price * 100).to_i
  end
end
