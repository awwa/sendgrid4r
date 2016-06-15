module SendGrid4r::CLI
  module Settings
    class Partner < SgThor

      desc 'list', 'List partner settings'
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_partner_settings(
          limit: options[:limit],
          offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'new_relic', 'Get, Enable and Disable new relic settings'
      option :license_key
      def new_relic(action)
        case action
        when 'get'
          puts @client.get_settings_new_relic
        when 'enable'
          params = {
            enabled: true,
            license_key: options[:license_key]
          }
          puts @client.patch_settings_new_relic(params: params)
        when 'disable'
          params = {
            enabled: false
          }
          puts @client.patch_settings_new_relic(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
