module SendGrid4r::CLI
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Ip
    #
    class Ip < SgThor
      desc 'list', 'List all IP whitelabels'
      option :ip
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_wl_ips(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create an IP whitelabel'
      option :ip, require: true
      option :domain, require: true
      option :subdomain, require: true
      def create
        puts @client.post_wl_ip(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Retrieve an IP whitelabel'
      option :id, require: true
      def get
        puts @client.get_wl_ip(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete an IP whitelabel'
      option :id, require: true
      def delete
        puts @client.delete_wl_ip(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'validate', 'Validate IP whitelabel'
      option :id, require: true
      def validate
        puts @client.validate_wl_ip(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
