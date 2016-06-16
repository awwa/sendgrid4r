module SendGrid4r::CLI
  module Ips
    #
    # SendGrid Web API v3 Ips Warmup
    #
    class Warmup < SgThor
      desc 'list', 'List all IP addresses that are currently warming up'
      def list
        puts @client.get_warmup_ips
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get warmup status for a particular IP address'
      option :ip, require: true
      def get
        puts @client.get_warmup_ip(ip: options[:ip])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'start', 'Start warmup'
      option :ip, require: true
      def start
        puts @client.post_warmup_ip(ip: options[:ip])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'stop', 'Stop warmup'
      option :ip, require: true
      def stop
        puts @client.delete_warmup_ip(ip: options[:ip])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
