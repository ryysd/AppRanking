class Proxy < ActiveRecord::Base
  def get_https_proxies (api_key: '9cbcfed29b7659add44113b5', limit: 100, timeout: 10)
    self.get_https_proxies_from_letushide api_key, limit, timeout
  end

  def get_https_proxies_from_letushide (api_key:, limit:, timeout:)
    RestClient::Request.execute :method => :get, 
      :url => "http://letushide.com/fpapi/?key=#{api_key}&num=#{limit}&cs=#{@code}&ps=https&format=json", 
      :timeout => timeout, 
      :open_timeout => timeout
  end
end
