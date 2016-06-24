module SendGrid4r::CLI
  module Settings
    #
    # SendGrid Web API v3 Settings Mail
    #
    class Mail < SgThor
      desc 'list', 'List mail settings'
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_mail_settings(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'whitelist <action>',
        'Get, Enable and Disable address whitelist settings'
      )
      option :list, type: :array
      def whitelist(action)
        case action
        when 'get'
          puts @client.get_settings_address_whitelist
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_address_whitelist(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'bcc <action>', 'Get, Enable and Disable bcc settings'
      option :email
      def bcc(action)
        case action
        when 'get'
          puts @client.get_settings_bcc
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_bcc(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'bounce_purge <action>', 'Get, Enable and Disable bounce purge settings'
      )
      option :hard_bounces, type: :numeric
      option :soft_bounces, type: :numeric
      def bounce_purge(action)
        case action
        when 'get'
          puts @client.get_settings_bounce_purge
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_bounce_purge(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'footer <action>', 'Get, Enable and Disable footer settings'
      option :html_content
      option :plain_content
      def footer(action)
        case action
        when 'get'
          puts @client.get_settings_footer
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_footer(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'forward_bounce <action>',
        'Get, Enable and Disable forward bounce settings'
      )
      option :email
      def forward_bounce(action)
        case action
        when 'get'
          puts @client.get_settings_forward_bounce
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_forward_bounce(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'forward_spam <action>', 'Get, Enable and Disable forward spam settings'
      )
      option :email
      def forward_spam(action)
        case action
        when 'get'
          puts @client.get_settings_forward_spam
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_forward_spam(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'spam_check <action>', 'Get, Enable and Disable spam check settings'
      option :url
      option :max_score
      def spam_check(action)
        case action
        when 'get'
          puts @client.get_settings_spam_check
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_spam_check(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'template <action>', 'Get, Enable and Disable template settings'
      option :html_content
      def template(action)
        case action
        when 'get'
          puts @client.get_settings_template
        when 'enable', 'disable'
          params = parameterise(options)
          params[:enabled] = action == 'enable'
          puts @client.patch_settings_template(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'plain_content <action>',
        'Get, Enable and Disable plain content settings'
      )
      def plain_content(action)
        case action
        when 'get'
          puts @client.get_settings_plain_content
        when 'enable', 'disable'
          params = { enabled: action == 'enable' }
          puts @client.patch_settings_plain_content(params: params)
        else
          puts "error: #{action} is not supported in action parameter"
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
