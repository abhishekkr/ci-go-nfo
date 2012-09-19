## ci-go-nfo : your console mate for ThoughtWorks' Go CI

ci_libs = File.join(File.dirname(File.expand_path __FILE__), 'ci-go-nfo', '*.rb')
Dir.glob(ci_libs).each do |lib|
    require lib
end
require 'xml-motor'

module Ci
  module Go
    module Nfo

      def self.cli(filter = nil)
        go = Ci::Go::Cctray.data_from_xml
        go['names'].each_with_index do |name, idx|
          next if name.split('::').size < 3
          status = <<-STATUS
\e[1m\e[31m#{name.gsub('::', '->')}
\e[32m#{go['lastBuildStatus'][idx]} \e[0m for run#\e[32m#{go['lastBuildLabels'][idx]} \e[33mat #{go['lastBuildTimes'][idx]}
\e[0mdetails at \e[36m#{go['weburls'][idx]}

          STATUS
          if filter.nil?
            puts status
          elsif filter === 'fail' && go['lastBuildStatus'][idx]==='Failure'
            puts status
          elsif filter === 'pass' && go['lastBuildStatus'][idx]==='Success'
            puts status
          end
        end
      end

    end
  end
end
