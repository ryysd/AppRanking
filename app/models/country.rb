require 'rubygems'
require 'rest_client'

class Country < ActiveRecord::Base
  def own_country?
    # TODO: compare to country code of location of server
    @code == 'JP'
  end
end
