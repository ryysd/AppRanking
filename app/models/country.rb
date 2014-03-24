require 'rubygems'
require 'rest_client'

class Country < ActiveRecord::Base
  def own?
    # TODO: compare to country code of location of server
    self.code == 'JP'
  end
end
