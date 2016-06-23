module SendGrid4r::CLI
  module Subusers
    #
    # SendGrid Web API v3 Subusers Subuser
    #
    class Subuser < SgThor
      desc 'list', 'List subusers for a parent'
      option :limit, type: :numeric
      option :offset, type: :numeric
      option :username
      def list
        puts @client.get_subusers(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create a subuser'
      option :username, require: true
      option :email, require: true
      option :password, require: true
      option :ips, type: :array, require: true
      def create
        puts @client.post_subuser(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable', 'Enable a subuser'
      option :username, require: true
      def enable
        params = parameterise(options)
        params[:disabled] = false
        puts @client.patch_subuser(params)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable', 'Disable a subuser'
      option :username, require: true
      def disable
        params = parameterise(options)
        params[:disabled] = false
        puts @client.patch_subuser(params)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a subuser'
      option :username, require: true
      def delete
        puts @client.delete_subuser(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'reputation', 'Retrieve subusers reputation'
      option :usernames, type: :array, require: true
      def reputation
        puts @client.get_subuser_reputation(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'assign_ips', 'Update IPs assigned to a subuser'
      option :username, require: true
      option :ips, type: :array, require: true
      def assign_ips
        puts @client.put_subuser_assigned_ips(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('monitor SUBCOMMAND ...ARGS', 'Manage monitor records for subuser')
      subcommand('monitor', Monitor)
    end
  end
end
