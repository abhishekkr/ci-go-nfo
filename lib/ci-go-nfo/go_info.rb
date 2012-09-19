## go_info.rb

require 'yaml'

module Ci
  module Go
    module Access

      def self.config_from(new_file = nil)
        gem = File.join File.expand_path(File.dirname __FILE__), '..', '..'
        gem_res = File.join gem, 'resource', 'config.store'
        if new_file.nil?
          from_file = File.open(gem_res, 'r'){|fyl| fyl.read}
          return from_file.chop.gsub(/^~/,File.expand_path('~'))
        end
        new_file = new_file.chop.gsub(/^~/,File.expand_path('~'))
        File.open(gem_res, 'w'){|fyl| fyl.puts new_file}
        new_file
      end

      def self.config
        conf_fyl = config_from
        if File.exists? conf_fyl
          defaults = YAML.load_file conf_fyl
        else
          defaults = persist_config
        end
        defaults = persist_config unless defaults
        baseurl  = defaults['baseurl']
        unless defaults['creds'].nil?
          user     = defaults['creds']['user']
          password = defaults['creds']['pass']
        end
        if baseurl.nil?
          return persist_config_from
        else
          return {'user' => user, 'password' => password, 'baseurl' => baseurl}
        end
      end

      def self.persist_config
        inputs = setup_access
        config_hash = {
                        'baseurl' => inputs['baseurl'],
                        'creds' => {
                                    'user' => inputs['user'],
                                    'pass' => inputs['password']
                                  }
                      }
        config_from inputs['config_from'] unless inputs['config_from'].empty?
        File.open(config_from, 'w+') do |conf|
          conf.write( config_hash.to_yaml )
        end

        {
         'baseurl' => inputs['baseurl'],
         'user'    => inputs['user'],
         'pass'    => inputs['password']
        }
      end

      def self.setup_access
        ARGV.clear
        print "\nStore sensitive Go Configs in file {current file: #{config_from}}: "
        conf_file = gets.strip
        print "\nEnter Base URL of Go Server {like http://<ip>:8153}: "
        baseurl = gets.strip
        puts "\nThis is better to be ReadOnly account details..."
        print "\nEnter Log-in UserName: "
        user = gets.strip
        print "\nPassword: "
        password = gets.strip
        {'config_from' => conf_file, 'user' => user, 'password' => password, 'baseurl' => baseurl}
      end
    end
  end
end
