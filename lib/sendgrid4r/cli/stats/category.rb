module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Category
    #
    class Category < SgThor
      desc 'get', 'Gets email statistics for the given categories.'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :categories, require: true
      def get
        puts @client.get_categories_stats(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc(
        'sums',
        'Gets the total sums of each email statistic metric for all categories'
      )
      option :start_date, require: true
      option :end_date
      option :sort_by_metric
      option :sort_by_direction
      option :limit
      option :offset
      def sums
        puts @client.get_categories_stats_sums(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
