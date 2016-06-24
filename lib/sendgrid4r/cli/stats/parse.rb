module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Parse
    #
    class Parse < SgThor
      desc 'get', 'Gets statistics for Parse Webhook usage'
      option :start_date, banner: SgThor::ISO, require: true
      option :end_date, banner: SgThor::ISO
      option :aggregated_by
      def get
        puts @client.get_parse_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
