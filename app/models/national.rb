class National < ActiveRecord::Base
  attr_accessor :description, :price

  has_many :description, :foreign_key => :national_id
  has_one :price, :foreign_key => :national_id

  accepts_nested_attributes_for :price, :description

  before_create :load
  
  def load
    self.description = Description.new text: description
    self.price = Price.new value: (price * 100).to_i
  end
end
