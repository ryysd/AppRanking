require 'rubygems'
require 'rest_client'

class Country < ActiveRecord::Base
  has_many :proxies

  scope :popular, lambda{where(['is_popular = ?', 1])}

  def to_json
    {code: self.code, name: self.name}
  end

  def own?
    # TODO: compare to country code of location of server
    self.code == 'JP'
  end
end
