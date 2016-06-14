module SendGrid4r::CLI
  module Subusers
    class Subuser < SgThor

      desc 'list', 'List subusers for a parent'
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      option :username
      def list
        puts @client.get_subusers(
          limit: options[:limit], offset: options[:offset],
          username: options[:username]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create a subuser'
      option :username, :require => true
      option :email, :require => true
      option :password, :require => true
      option :ips, :type => :array, :require => true
      def create
        puts @client.post_subuser(
          username: options[:username], email: options[:email],
          password: options[:password], ips: options[:ips]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable', 'Enable a subuser'
      option :username, :require => true
      def enable
        puts @client.patch_subuser(
          username: options[:username], disabled: false
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable', 'Disable a subuser'
      option :username, :require => true
      def disable
        puts @client.patch_subuser(
          username: options[:username], disabled: true
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a subuser'
      option :username, :require => true
      def delete
        puts @client.delete_subuser(username: options[:username])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'reputation', 'Retrieve subusers reputation'
      option :usernames, :type => :array, :require => true
      def reputation
        puts @client.get_subuser_reputation(
          usernames: options[:usernames]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'assign_ips', 'Update IPs assigned to a subuser'
      option :username, :require => true
      option :ips, :type => :array, :require => true
      def assign_ips
        puts @client.put_subuser_assigned_ips(
          username: options[:username], ips: options[:ips]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('monitor SUBCOMMAND ...ARGS', 'Manage monitor records for subuser')
      subcommand('monitor', Monitor)
    end
  end
end
