module SendGrid4r::CLI
  module ApiKeys
    #
    # SendGrid Web API v3 ApiKeys Permission
    #
    class Permission < SgThor
      desc 'list', 'List all available scopes for a user'
      def list
        puts @client.get_permissions
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
