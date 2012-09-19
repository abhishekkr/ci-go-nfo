## www.rb

require 'net/http'
require 'uri'

module Ci
  module WWW

    def self.http
      config = Ci::Go::Access.config
      url = URI.parse("#{config['baseurl']}/go/cctray.xml")
      req = Net::HTTP::Get.new(url.path)
      req.basic_auth(config['user'], config['password']) unless config['user'].nil?
      Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
    end
  end
end
