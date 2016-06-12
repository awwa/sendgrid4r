module SendGrid4r::CLI
  module ApiKeys
    class ApiKey < SgThor

      desc 'list', 'List API keys'
      def list
        puts @client.get_api_keys
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create an API key'
      option :name, :require => true
      option :scopes, :type => :array
      def create
        puts @client.post_api_key(
          name: options[:name],
          scopes: options[:scopes]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get an API key'
      option :api_key_id, :require => true
      def get
        puts @client.get_api_key(api_key_id: options[:api_key_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete an API key'
      option :api_key_id, :require => true
      def delete
        puts @client.delete_api_key(api_key_id: options[:api_key_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update an API key'
      option :api_key_id, :require => true
      option :name
      option :scopes
      def update
        puts @client.put_api_key(
          api_key_id: options[:api_key_id], name: options[:name],
          scopes: options[:scopes]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('permission SUBCOMMAND ...ARGS', 'Manage permission for API key')
      subcommand('permission', Permission)
    end
  end
end
