module SendGrid4r::CLI
  module Settings
    #
    # SendGrid Web API v3 Settings Tracking
    #
    class Tracking < SgThor
      desc 'list', 'List tracking settings'
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_tracking_settings(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'click <action>', 'Get, Enable and Disable click tracking settings'
      def click(action)
        case action
        when 'get'
          puts @client.get_settings_click
        when 'enable', 'disable'
          params = { enabled: action == 'enable' }
          puts @client.patch_settings_click(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'ganalytics <action>',
        'Get, Enable and Disable google analytics settings'
      )
      option :utm_source
      option :utm_medium
      option :utm_term
      option :utm_content
      option :utm_campaign
      def ganalytics(action)
        case action
        when 'get'
          puts @client.get_settings_google_analytics
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_google_analytics(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'open <action>', 'Get, Enable and Disable open tracking settings'
      def open(action)
        case action
        when 'get'
          puts @client.get_settings_open
        when 'enable', 'disable'
          params = { enabled: action == 'enable' }
          puts @client.patch_settings_open(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'subscription <action>',
        'Get, Enable and Disable subscription tracking settings'
      )
      option :landing
      option :url
      option :replace
      option :html_content
      option :plain_content
      def subscription(action)
        case action
        when 'get'
          puts @client.get_settings_subscription
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
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
