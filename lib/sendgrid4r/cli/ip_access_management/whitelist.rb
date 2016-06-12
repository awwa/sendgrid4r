module SendGrid4r::CLI
  module IpAccessManagement
    class Whitelist < SgThor

      desc 'list', 'List Whitelisted IPs'
      def list
        puts @client.get_whitelisted_ips
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'add', 'Add Whitelisted IPs'
      option :ips, :type => :array, :require => true
      def add
        puts @client.post_whitelisted_ips(ips: options[:ips])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete Whitelisted IPs'
      option :ids, :type => :array
      option :rule_id, :type => :numeric
      def delete
        if options[:rule_id]
          puts @client.delete_whitelisted_ip(rule_id: options[:rule_id])
        end
        if options[:ids]
          puts @client.delete_whitelisted_ips(ids: options[:ids])
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a Whitelisted IP'
      option :rule_id, :type => :numeric, :require => true
      def get
        puts @client.get_whitelisted_ip(rule_id: options[:rule_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
