module SendGrid4r::CLI
  module Stats
    #
    # SendGrid Web API v3 Stats Advanced
    #
    class Advanced < SgThor
      desc 'geo', 'Gets email statistics by country and state/province'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :country
      def geo
        puts @client.get_geo_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by], country: options[:country]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'device', 'Gets email statistics by device type'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      def device
        puts @client.get_devices_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'client', 'Gets email statistics by client type'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      def client
        puts @client.get_clients_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'client_type', 'Gets email statistics for a single client type'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :client_type, require: true
      def client_type
        puts @client.get_clients_type_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          client_type: options[:client_type]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'mailbox_provider', 'Gets email statistics by mailbox provider'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :mailbox_providers
      def mailbox_provider
        puts @client.get_mailbox_providers_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          esps: options[:mailbox_providers]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'browser', 'Gets email statistics by browser'
      option :start_date, require: true
      option :end_date
      option :aggregated_by
      option :browsers
      def browser
        puts @client.get_browsers_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          browsers: options[:browsers]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
