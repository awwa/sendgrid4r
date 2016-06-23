module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Subuser
    #
    class Subuser < SgThor
      desc 'get', 'Gets email statistics for the given subusers'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :subusers, type: :array, require: true
      def get
        puts @client.get_subusers_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'sums',
        'Gets the total sums of each email statistic metric for all subusers'
      )
      option :start_date, require: true
      option :end_date
      option :sort_by_metric
      option :sort_by_direction
      option :limit, type: :numeric
      option :offset, type: :numeric
      def sums
        puts @client.get_subusers_stats_sums(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'list_monthly',
        'Retrieve the monthly email statistics for all subusers'
      )
      option :date, require: true
      option :subuser
      option :sort_by_metric
      option :sort_by_direction
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list_monthly
        puts @client.get_subusers_stats_monthly(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'get_monthly',
        'Retrieve the monthly email statistics for a single subuser'
      )
      option :subuser_name, require: true
      option :date, require: true
      option :sort_by_metric
      option :sort_by_direction
      option :limit, type: :numeric
      option :offset, type: :numeric
      def get_monthly
        puts @client.get_subuser_stats_monthly(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
