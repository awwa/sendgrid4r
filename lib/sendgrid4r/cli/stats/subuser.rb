module SendGrid4r::CLI
  module Stats
    class Subuser < SgThor

      desc 'get', 'Gets email statistics for the given subusers'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      option :subusers, :type => :array, :require => true
      def get
        puts @client.get_subusers_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by], subusers: options[:subusers]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'sums', 'Gets the total sums of each email statistic metric for all subusers over the given date range'
      option :start_date, :require => true
      option :end_date
      option :sort_by_metric
      option :sort_by_direction
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def sums
        puts @client.get_subusers_stats_sums(
          start_date: options[:start_date], end_date: options[:end_date],
          sort_by_metric: options[:sort_by_metric],
          sort_by_direction: options[:sort_by_direction],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list_monthly', 'Retrieve the monthly email statistics for all subusers over the given date range'
      option :date, :require => true
      option :subuser
      option :sort_by_metric
      option :sort_by_direction
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list_monthly
        puts @client.get_subusers_stats_monthly(
          date: options[:date], subuser: options[:subuser],
          sort_by_metric: options[:sort_by_metric],
          sort_by_direction: options[:sort_by_direction],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get_monthly', 'Retrieve the monthly email statistics for a single subuser'
      option :subuser, :require => true
      option :date, :require => true
      option :sort_by_metric
      option :sort_by_direction
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def get_monthly
        puts @client.get_subuser_stats_monthly(
          subuser_name: options[:subuser], date: options[:date],
          sort_by_metric: options[:sort_by_metric],
          sort_by_direction: options[:sort_by_direction],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
