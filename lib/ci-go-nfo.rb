## ci-go-nfo : your console mate for ThoughtWorks' Go CI

ci_libs = File.join(File.dirname(File.expand_path __FILE__), 'ci-go-nfo', '*.rb')
Dir.glob(ci_libs).each do |lib|
    require lib
end
require 'xml-motor'

module Ci
  module Go
    module Nfo

      def self.summary
        go_all = Ci::Go::Cctray.data_from_xml
        failed_builds, passed_builds = [], []
        go_all['names'].each_with_index do |name, idx|
          name_split = name.split('::')
          next unless name_split.size == 3
          if passed? go_all, idx
            passed_builds.push name_split[0]
          else
            failed_builds.push name_split[0]
          end
        end
        failed_builds = failed_builds.uniq
        passed_builds = passed_builds.uniq.select{|build|
                         not failed_builds.include? build
                       }

        Ci::Go::Print.summary passed_builds, failed_builds
      end

      def self.builds(status = nil)
        go = Ci::Go::Cctray.data_from_xml
        go['names'].each_with_index do |name, idx|
          next if name.split('::').size < 3
          build = build_nfo(go, idx)

          if status.nil? or
            build['last_status'].match(/#{status}/i) or
            ( status === 'pass' && build['last_status'] === 'Success' )
            Ci::Go::Print.build_status build
          end
        end
      end

      def self.build_of(pipeline)
        go          = Ci::Go::Cctray.data_from_xml
        build_name  = go['names'].select{|gname| gname.split(/::/)[0] === pipeline}
        idx         = go.index build_name

        Ci::Go::Print.build_status build_nfo(go, idx)
      end

      def self.build_nfo(goXML, index)
        {
          'name'        => goXML['names'][index],
          'last_status' => goXML['lastBuildStatus'][index],
          'last_label'  => goXML['lastBuildLabels'][index],
          'last_time'   => goXML['lastBuildTimes'][index],
          'weburl'      => goXML['weburls'][index]
        }
      end

      def self.passed?(goXML, index)
        goXML['lastBuildStatus'][index] === 'Success'
      end
    end
  end
end
