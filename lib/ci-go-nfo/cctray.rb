## cctray.rb
# Ci::Go::Cctray.data_from_xml ~ return hash of array of fields in Go CCTray XML

require 'xml-motor'

module Ci
  module Go
    module Cctray

      def self.data_from_xml
        cctray = Ci::WWW::Go.cctray_xml
        splitd = XMLMotor.splitter cctray.body
        tags   = XMLMotor.indexify splitd
        go_nfo = {}

        go_nfo['names'] = XMLMotor.xmlattrib 'name', splitd, tags, 'Project'
        go_nfo['lastBuildStatus'] = XMLMotor.xmlattrib 'lastBuildStatus', splitd, tags, 'Project'
        go_nfo['lastBuildLabels'] = XMLMotor.xmlattrib 'lastBuildLabel', splitd, tags, 'Project'
        go_nfo['lastBuildTimes']  = XMLMotor.xmlattrib 'lastBuildTime', splitd, tags, 'Project'
        go_nfo['weburls']         = XMLMotor.xmlattrib 'webUrl', splitd, tags, 'Project'
        go_nfo
      end
    end
  end
end
