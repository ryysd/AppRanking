class National < ActiveRecord::Base
  attr_accessor :description, :price

  has_one :description, :foreign_key => :national_id
  has_one :price, :foreign_key => :national_id

  accepts_nested_attributes_for :price, :description
  
  def before_save
    self.description = Description.new text: description
    self.price = Price.new value: (price * 100).to_i
  end
end
