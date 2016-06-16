module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Parse
    #
    class Parse < SgThor
      desc 'get', 'Gets statistics for Parse Webhook usage'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      def get
        puts @client.get_parse_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
