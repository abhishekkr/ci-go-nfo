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
          if name.split('::').size == 3
            if go_all['lastBuildStatus'][idx] === 'Failure'
              failed_builds << name.split('::')[0]
            elsif go_all['lastBuildStatus'][idx] === 'Success'
              passed_builds << name.split('::')[0]
            end
          end
        end
        Ci::Go::Print.summary passed_builds.uniq, failed_builds.uniq
      end

      def self.builds(status = nil)
        go = Ci::Go::Cctray.data_from_xml
        go['names'].each_with_index do |name, idx|
          next if name.split('::').size < 3
          build = {
                    'name'        => name,
                    'last_status' => go['lastBuildStatus'][idx],
                    'last_label'  => go['lastBuildLabels'][idx],
                    'last_time'   => go['lastBuildTimes'][idx],
                    'weburl'      => go['weburls'][idx]
                  }

          if status.nil?
            Ci::Go::Print.build_status build
          elsif status === 'fail' && build['last_status'] === 'Failure'
            Ci::Go::Print.build_status build
          elsif status === 'pass' && build['last_status'] === 'Success'
            Ci::Go::Print.build_status build
          end
        end
      end

      def self.build_of(pipeline)
        go          = Ci::Go::Cctray.data_from_xml
        build_name  = go['names'].select{|gname| gname.split(/::/)[0] === pipeline}
        idx         = go.index build_name
        build = {
                  'name'        => go['names'][idx],
                  'last_status' => go['lastBuildStatus'][idx],
                  'last_label'  => go['lastBuildLabels'][idx],
                  'last_time'   => go['lastBuildTimes'][idx],
                  'weburl'      => go['weburls'][idx]
                }

        Ci::Go::Print.build_status build
      end

    end
  end
end
