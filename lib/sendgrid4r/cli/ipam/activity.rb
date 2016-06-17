module SendGrid4r::CLI
  module Ipam
    #
    # SendGrid Web API v3 Ipam Activity
    #
    class Activity < SgThor
      desc 'list', 'History Collection'
      option :limit, type: :numeric
      def list
        puts @client.get_ip_activities(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
