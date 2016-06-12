module SendGrid4r::CLI
  module IpAccessManagement
    class Activity < SgThor

      desc 'list', 'History Collection'
      option :limit, :type => :numeric
      def list
        puts @client.get_ip_activities(limit: options[:limit])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
