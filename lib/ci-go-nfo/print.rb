## print.rb

module Ci
  module Go
    module Print

      def self.summary(passed_builds, failed_builds)
        puts <<-OUTPUT
\e[1m\e[94mCI Summary\e[0m
 Total \e[94mPipelines:\e[0m \e[94m#{passed_builds.size + failed_builds.size}\e[0m
 Total \e[32mPassed\e[0m Pipelines: \e[94m#{passed_builds.size}\e[0m
 Total \e[31mFailed\e[0m Pipelines: \e[94m#{failed_builds.size}\e[0m
   \e[91mFailed\e[0m Build are:
        OUTPUT
        failed_builds.each do |build|
          puts "      \e[31m\e[1m#{build}\e[0m"
        end
      end

      def self.build_status(build)
        puts <<-OUTPUT
\e[1m\e[31m#{build['name'].gsub('::', '->')}
\e[32m#{build['last_status']} \e[0m for run#\e[32m#{build['last_label']} \e[33mat #{build['last_time']}
\e[0mdetails at \e[36m#{build['weburl']}

        OUTPUT
      end

    end
  end
end
