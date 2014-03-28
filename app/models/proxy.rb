class Proxy < ActiveRecord::Base
  # TODO:
  # https://hidemyass.com/proxy-list/
  # http://www.aliveproxy.com/
  # http://www.sslproxies.org/
  # http://proxyhttp.net/free-list/proxy-https-security-anonymous-proxy/
  # http://spys.ru/en/https-ssl-proxy/
  # http://proxy-list.org/english/index.php
  # http://tools.rosinstrument.com/proxy/
  # http://gatherproxy.com
  # http://www.idcloak.com/proxylist/ssl-proxy.html#sort
  # http://free-proxy-list.net/
  #
  # buy
  # http://www.buyproxylist.com/
  
  belongs_to :protocol
  belongs_to :country

  validates :host, :uniqueness => { :scope => [:port, :protocol_id] }

  TIMEOUT = 10.freeze
  SSL_TEST_TIMEOUT = 5.freeze

  SSL_TEST_SITE_URLS = [
      'https://ssltest23.bbtest.net/',
  ].freeze

  def self.create_ssl_proxies
    letushide_proxies = Proxy.get_ssl_proxies_from_letushide
    xroxy_proxies = Proxy.get_proxies_from_xroxy
    proxies = letushide_proxies + xroxy_proxies

    proxies.map{|proxy| 
      args = {
	host: proxy[:host], 
	port: proxy[:port],
	protocol: (Protocol.find_by_name proxy[:protocol]),
	country: (Country.find_by_code proxy[:country])
      }

      Proxy.new args if (args[:protocol].name != 'http' && args[:country].code != 'ZZ')
    }.compact
  end

  def self.get_ssl_proxies_from_letushide
    country_codes = Country.all.each_slice(10).map{|countries|
      countries.map{|c| c.code}.reduce{|l, r| "#{l},#{r}"}
    }

    country_codes.first(3).map {|country_code|
      Proxy.get_proxies_from_letushide country_code: country_code, protocol: 'https'
    }.flatten.compact
  end

  def self.get_ssl_proxies_from_xroxy
    Proxy.get_proxies_from_xroxy.select{|proxy| proxy[:protocol].downcase != 'http'}
  end

  def self.get_proxies_from_letushide (api_key: '9cbcfed29b7659add44113b5', limit: '120', country_code:, protocol: , timeout: Proxy::TIMEOUT)
    json = RestClient::Request.execute :method => :get, 
      :url => "http://letushide.com/fpapi/?key=#{api_key}&num=#{limit}&cs=#{country_code}&ps=#{protocol}&format=json", 
      :timeout => timeout, 
      :open_timeout => timeout

    parsed_json = JSON.parse json
    parsed_json['data'].map{|data|
      {
	host: data['host'], 
	port: data['port'], 
	protocol: data['protocol'], 
	country: data['country']
      }
    }
  end

  def self.get_proxies_from_xroxy(timeout: Proxy::TIMEOUT)
    xml = RestClient::Request.execute :method => :get, 
      :url => "http://www.xroxy.com/proxyrss.xml", 
      :timeout => timeout, 
      :open_timeout => timeout

    parsed_json = JSON.parse (Hash.from_xml xml).to_json
    parsed_json['rss']['channel']['item'].map{|item|
      item['proxy'].map{|data|
	next if data.class.to_s == 'Array'

	protocol = data['type']
	if protocol != 'Socks4' && protocol != 'Socks5'
	  protocol = (data['ssl'] == 'false') ? 'http' : 'https'
	end

	{
	  host: data['ip'],
	  port: data['port'],
	  protocol:protocol,
	  country: data['country_code']
	}
      }
    }.flatten.compact
  end

  def self.check_ssl(host:, port:)
    test_site = Proxy::SSL_TEST_SITE_URLS.sample
    response = Typhoeus.get test_site, proxy: "#{host}:#{port}", timeout: Proxy::SSL_TEST_TIMEOUT, connecttimeout: Proxy::SSL_TEST_TIMEOUT
    (!response.timed_out? && !response.body.empty?)
  end
end
