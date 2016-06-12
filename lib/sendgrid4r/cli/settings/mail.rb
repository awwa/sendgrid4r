module SendGrid4r::CLI
  module Settings
    class Mail < SgThor

      desc 'list', 'List mail settings'
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_mail_settings(
          limit: options[:limit],
          offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_whitelist', 'Get address whitelist settings'
      def get_whitelist
        puts @client.get_settings_address_whitelist
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_whitelist', 'Enable address whitelist settings'
      option :list, :type => :array
      def enable_whitelist
        options[:enabled] = true
        puts @client.patch_settings_address_whitelist(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_whitelist', 'Disable address whitelist settings'
      def disable_whitelist
        options = { enabled: false }
        puts @client.patch_settings_address_whitelist(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_bcc', 'Get bcc settings'
      def get_bcc
        puts @client.get_settings_bcc
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_bcc', 'Enable bcc settings'
      option :email
      def enable_bcc
        optios[:enabled] = true
        puts @client.patch_settings_bcc(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_bcc', 'Disable bcc settings'
      def disable_bcc
        options = { enabled: false }
        puts @client.patch_settings_bcc(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_bounce_purge', 'Get bounce purge settings'
      def get_bounce_purge
        puts @client.get_settings_bounce_purge
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_bounce_purge', 'Enable bounce purge settings'
      option :hard_bounces, :type => :numeric
      option :soft_bounces, :type => :numeric
      def enable_bounce_purge
        options[:enabled] = true
        puts @client.patch_settings_bounce_purge(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_bounce_purge', 'Disable bounce purge settings'
      def disable_bounce_purge
        options = { enabled: false }
        puts @client.patch_settings_bounce_purge(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_footer', 'Get footer settings'
      def get_footer
        puts @client.get_settings_footer
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_footer', 'Enable footer settings'
      option :html_content
      option :plain_content
      def enable_footer
        options[:enabled] = true
        puts @client.patch_settings_footer(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_footer', 'Disable footer settings'
      def disable_footer
        options = { enabled: false }
        puts @client.patch_settings_footer(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_forward_bounce', 'Get forward bounce settings'
      def get_forward_bounce
        puts @client.get_settings_forward_bounce
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_forward_bounce', 'Enable forward bounce settings'
      option :email
      def enable_forward_bounce
        options[:enabled] = true
        puts @client.patch_settings_forward_bounce(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_forward_bounce', 'Disable forward bounce settings'
      def disable_forward_bounce
        options = { enabled: false }
        puts @client.patch_settings_forward_bounce(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_forward_spam', 'Get forward spam settings'
      def get_forward_spam
        puts @client.get_settings_forward_spam
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_forward_spam', 'Enable forward spam settings'
      option :url
      option :max_score
      def enable_forward_spam
        options[:enabled] = true
        puts @client.patch_settings_forward_spam(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_forward_spam', 'Disable forward spam settings'
      def disable_forward_spam
        options = { enabled: false }
        puts @client.patch_settings_forward_spam(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_template', 'Get template settings'
      def get_template
        puts @client.get_settings_template
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_template', 'Enable template settings'
      option :html_content
      def enable_template
        options[:enabled] = true
        puts @client.patch_settings_template(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_template', 'Disable template settings'
      def disable_template
        options = { enabled: false }
        puts @client.patch_settings_template(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_plain_content', 'Get plain content settings'
      def get_plain_content
        puts @client.get_settings_plain_content
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable_plain_content', 'Enable plain content settings'
      def enable_plain_content
        options[:enabled] = true
        puts @client.patch_settings_plain_content(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable_plain_content', 'Disable plain content settings'
      def disable_plain_content
        options = { enabled: false }
        puts @client.patch_settings_plain_content(params: options)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
