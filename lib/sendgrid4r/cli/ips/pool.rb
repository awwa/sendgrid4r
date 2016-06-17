module SendGrid4r::CLI
  module Ips
    #
    # SendGrid Web API v3 Ips Pool
    #
    class Pool < SgThor
      desc 'create', 'Create an IP pool'
      option :name, require: true
      def create
        puts @client.post_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List all IP pools'
      def list
        puts @client.get_pools
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get an IP pool'
      option :name, require: true
      def get
        puts @client.get_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'rename', 'Rename an IP pool'
      option :name, require: true
      option :new_name, require: true
      def rename
        puts @client.put_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete an IP pool'
      option :name, require: true
      def delete
        puts @client.delete_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
