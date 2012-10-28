## www.rb
# Ci::WWW.http ~ takes url and config{:user, :password}, gives http response 
# Ci::WWW::Go.cctray_xml ~ return cctray.xml http response

require 'net/http'
require 'uri'

module Ci
  module WWW

    def self.http(url, config)
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.path)
      req.basic_auth(config['user'], config['password']) unless config['user'].nil?
      Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
    end
  end
end


module Ci
  module WWW
    module Go

      def self.cctray_xml
        config = Ci::Go::Access.config
        url    = "#{config['baseurl']}/go/cctray.xml"
        Ci::WWW.http url, config
      end
    end
  end
end
