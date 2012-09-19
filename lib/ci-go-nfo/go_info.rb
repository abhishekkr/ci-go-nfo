## go_info.rb

require 'yaml'

module Ci
  module Go
    module Access

      def self.config_from(new_file = nil)
        gem = File.join File.expand_path(File.dirname __FILE__), '..', '..'
        gem_res = File.join gem, 'resource', 'config.store'
        return File.open(gem_res, 'r'){|fyl| fyl.read}.chop if new_file.nil?
        File.open(gem_res, 'w'){|fyl| fyl.puts new_file}
        new_file
      end

      def self.config
        defaults = YAML.load_file config_from
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

      def self.persist_config_from
        inputs = setup_access
        config = {
                  'baseurl' => inputs['baseurl'],
                  'creds' => {
                              'user' => inputs['user'],
                              'pass' => inputs['password']
                             }
                 }
        config_from inputs['config_from']
        File.open(inputs['config_from'], 'w'){|conf|
          conf.write( config.to_yaml)
        }
        {'baseurl' => inputs['baseurl'],
         'user'    => inputs['user'],
         'pass'    => inputs['password']
        }
      end

      def self.setup_access
        ARGV.clear
        print "\nStore sensitive Go Configs in file {current file: #{config_from}}: "
        conf_file = gets.strip
        config_from(conf_file) unless conf_file.empty?
        print '\nEnter Base URL of Go Server {like http://<ip>:8153}: '
        baseurl = gets.strip
        puts 'This is better to be ReadOnly account details...'
        print '\nEnter Log-in UserName: '
        user = gets.strip
        print '\nPassword: '
        password = gets.strip
        {'config_from' => conf_file, 'user' => user, 'password' => password, 'baseurl' => baseurl}
      end
    end
  end
end
