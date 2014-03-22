require 'rubygems'
require 'rest_client'

class Country < ActiveRecord::Base
    def get_https_proxies (params = {})
	return get_https_proxies_from_letushide params
    end

    def get_https_proxies_from_letushide (params = {})
	api_key = '9cbcfed29b7659add44113b5' || params[:api_key]
	limit = 100 || params[:limit]
	timeout = 10 || params[:timeout]

	response = RestClient::Request.execute :method => :get, 
	    :url => "http://letushide.com/fpapi/?key=#{api_key}&num=#{limit}&cs=#{self.code}&ps=https&format=json", 
	    :timeout => timeout, 
	    :open_timeout => timeout

	return response
    end
end
