module SendGrid4r::CLI
  module Whitelabel
    class Ip < SgThor

      desc 'list', 'List all IP whitelabels'
      option :ip
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_wl_ips(
          ip: options[:ip], limit: options[:limit],
          offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create an IP whitelabel'
      option :ip, :require => true
      option :domain, :require => true
      option :subdomain, :require => true
      def create
        puts @client.post_wl_ip(
          ip: options[:ip], domain: options[:domain],
          subdomain: options[:subdomain]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Retrieve an IP whitelabel'
      option :id, :require => true
      def get
        puts @client.get_wl_ip(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete an IP whitelabel'
      option :id, :require => true
      def delete
        puts @client.delete_wl_ip(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'validate', 'Validate IP whitelabel'
      option :id, :require => true
      def validate
        puts @client.validate_wl_ip(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
