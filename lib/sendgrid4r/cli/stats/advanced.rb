module SendGrid4r::CLI
  module Statistics
    class Advanced < SgThor

      desc 'geo', 'Gets email statistics by country and state/province'
      option :start_date, :require => true
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

      desc 'devices', 'Gets email statistics by device type'
      option :start_date, :require => true
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

      desc 'clients', 'Gets email statistics by client type'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      def clients
        puts @client.get_clients_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'client', 'Gets email statistics for a single client type'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      option :client_type
      def client_type
        puts @client.get_clients_type_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          client_type: options[:client_type]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'mailbox_providers', 'Gets email statistics by mailbox provider'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      option :mailbox_providers
      def mailbox_providers
        puts @client.get_mailbox_providers_stats(
          start_date: options[:start_date], end_date: options[:end_date],
          aggregated_by: options[:aggregated_by],
          esps: options[:mailbox_providers]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'browsers', 'Gets email statistics by browser'
      option :start_date, :require => true
      option :end_date
      option :aggregated_by
      option :browsers
      def browsers
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
