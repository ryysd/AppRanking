class Proxy < ActiveRecord::Base
  def get_https_proxies (api_key: '9cbcfed29b7659add44113b5', limit: 120, timeout: 10, country_code:)
    self.get_https_proxies_from_letushide api_key, limit, timeout
  end

  def get_https_proxies_from_letushide (api_key:, limit:, country_code:, timeout:)
    RestClient::Request.execute :method => :get, 
      :url => "http://letushide.com/fpapi/?key=#{api_key}&num=#{limit}&cs=#{country_code}&ps=https&format=json", 
      :timeout => timeout, 
      :open_timeout => timeout
  end
end
