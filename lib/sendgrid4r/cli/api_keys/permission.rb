module SendGrid4r::CLI
  module ApiKeys
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
