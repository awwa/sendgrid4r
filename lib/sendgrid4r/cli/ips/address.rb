module SendGrid4r::CLI
  module Ips
    #
    # SendGrid Web API v3 Ips Address
    #
    class Address < SgThor
      desc 'add_to_pool', 'Add an IP address to a pool'
      option :pool_name, require: true
      option :ip, require: true
      def add_to_pool
        puts @client.post_ip_to_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List all IP addresses'
      def list
        puts @client.get_ips
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'assigned', 'List only assigned IP addresses'
      def assigned
        puts @client.get_ips_assigned
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get an IP address'
      option :ip, require: true
      def get
        puts @client.get_ip(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete_from_pool', 'Remove an IP address from a pool'
      option :pool_name, require: true
      option :ip, require: true
      def delete_from_pool
        puts @client.delete_ip_from_pool(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
