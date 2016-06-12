module SendGrid4r::CLI
  module Settings
    class Tracking < SgThor

      desc 'list', 'List tracking settings'
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_tracking_settings(
          limit: options[:limit],
          offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_click', 'Get click tracking settings'
      def get_click
        puts @client.get_settings_click
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_click', 'Enable click tracking settings'
      def enable_click
        options[:enabled] = true
        puts @client.patch_settings_click(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_click', 'Disable click tracking settings'
      def disable_click
        options = { enabled: false }
        puts @client.patch_settings_click(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_ganalytics', 'Get google analytics settings'
      def get_ganalytics
        puts @client.get_settings_google_analytics
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_ganalytics', 'Enable google analytics settings'
      option :utm_source
      option :utm_medium
      option :utm_term
      option :utm_content
      option :utm_campaign
      def enable_ganalytics
        options[:enabled] = true
        puts @client.patch_settings_google_analytics(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_ganalytics', 'Disable google analytics settings'
      def disable_ganalytics
        options = { enabled: false }
        puts @client.patch_settings_google_analytics(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_open', 'Get open tracking settings'
      def get_open
        puts @client.get_settings_open
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_open', 'Enable open tracking settings'
      def enable_open
        options[:enabled] = true
        puts @client.patch_settings_open(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_open', 'Disable open tracking settings'
      def disable_open
        options = { enabled: false }
        puts @client.patch_settings_open(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_subscription', 'Get subscription tracking settings'
      def get_subscription
        puts @client.get_settings_subscription
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_subscription', 'Enable subscription tracking settings'
      option :landing
      option :url
      option :replace
      option :html_content
      option :plain_content
      def enable_subscription
        options[:enabled] = true
        puts @client.patch_settings_subscription(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_subscription', 'Disable subscription tracking settings'
      def disable_subscription
        options = { enabled: false }
        puts @client.patch_settings_subscription(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
