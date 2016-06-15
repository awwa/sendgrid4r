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

      desc 'click', 'Get, Enable and Disable click tracking settings'
      def click(action)
        case action
        when 'get'
          puts @client.get_settings_click
        when 'enable'
          params = { enabled: true }
          puts @client.patch_settings_click(params: params)
        when 'disable'
          params = { enabled: false }
          puts @client.patch_settings_click(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'ganalytics', 'Get, Enable and Disable google analytics settings'
      option :utm_source
      option :utm_medium
      option :utm_term
      option :utm_content
      option :utm_campaign
      def ganalytics(action)
        case action
        when 'get'
          puts @client.get_settings_google_analytics
        when 'enable'
          params = {
            enabled: true,
            utm_source: options[:utm_source],
            utm_medium: options[:utm_medium],
            utm_term: options[:utm_term],
            utm_content: options[:utm_content],
            utm_campaign: options[:utm_campaign]
          }
          puts @client.patch_settings_google_analytics(params: params)
        when 'disable'
          params = { enabled: false }
          puts @client.patch_settings_google_analytics(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'open', 'Get, Enable and Disable open tracking settings'
      def open(action)
        case action
        when 'get'
          puts @client.get_settings_open
        when 'enable'
          params = { enabled: true }
          puts @client.patch_settings_open(params: params)
        when 'disable'
          params = { enabled: false }
          puts @client.patch_settings_open(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'subscription', 'Get, Enable and Disable subscription tracking settings'
      option :landing
      option :url
      option :replace
      option :html_content
      option :plain_content
      def subscription(action)
        case action
        when 'get'
          puts @client.get_settings_subscription
        when 'enable'
          params = { enabled: true }
          puts @client.patch_settings_subscription(params: params)
        when 'disable'
          params = { enabled: false }
          puts @client.patch_settings_subscription(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
