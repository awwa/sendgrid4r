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

      desc 'get_new_relic', 'Get new relic settings'
      def get_new_relic
        puts @client.get_new_relic
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_new_relic', 'Enable new relic settings'
      option :license_key
      def enable_new_relic
        options[:enabled] = true
        puts @client.patch_settings_new_relic(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_new_relic', 'Disable new relic settings'
      def disable_new_relic
        options = { enabled: false }
        puts @client.patch_settings_new_relic(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
