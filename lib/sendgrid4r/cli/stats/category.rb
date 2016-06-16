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
        puts @client.get_categories_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          categories: options[:categories]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'sums', 'Gets the total sums of each email statistic metric for all categories over the given date range.'
      option :start_date, require: true
      option :end_date
      option :sort_by_metric
      option :sort_by_direction
      option :limit
      option :offset
      def sums
        puts @client.get_categories_stats_sums(
          start_date: options[:start_date], end_date: options[:end_date],
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
