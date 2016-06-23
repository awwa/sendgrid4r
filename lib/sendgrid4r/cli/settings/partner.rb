module SendGrid4r::CLI
  module Settings
    #
    # SendGrid Web API v3 Settings Partner
    #
    class Partner < SgThor
      desc 'list', 'List partner settings'
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_partner_settings(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'new_relic', 'Get, Enable and Disable new relic settings'
      option :license_key
      def new_relic(action)
        case action
        when 'get'
          puts @client.get_settings_new_relic
        when 'enable', 'disabple'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
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
