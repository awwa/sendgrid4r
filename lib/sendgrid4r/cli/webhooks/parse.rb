module SendGrid4r::CLI
  module Webhooks
    class Parse < SgThor

      desc 'get', 'Get Parse Webhook Settings'
      def get
        puts @client.get_parse_settings
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
