module SendGrid4r::CLI
  module Stats
    class Global < SgThor

      desc 'get', 'Gets all of your user’s email statistics.'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      def get
        puts @client.get_global_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
